def _tree_artifact_rule(ctx):
    dir = ctx.actions.declare_directory(ctx.attr.dir)
    perms = ctx.actions.declare_file(ctx.attr.perms)
    ctx.actions.run_shell(
        command = """
        set -x
        mkdir $1/{bar,baz}
        echo "BAR" > $1/bar/bar.txt
        echo "BAZ" > $1/baz/baz.txt
        echo "Apparently umask [$(umask -S)] is honoured here:"
        find $1 -type d -printf "%M %p/\n" -o -printf "%M %p\n" | sed "s!$(dirname $1)!!" | tee $2
        """,
        arguments = [dir.path, perms.path],
        outputs = [dir, perms]
    )
    return [
        DefaultInfo(files = depset([dir])),
        OutputGroupInfo(perms = depset([perms]))
    ]

tree_artifact_rule = rule(
    implementation = _tree_artifact_rule,
    attrs = {
        "dir": attr.string(mandatory = True),
        "perms": attr.string(default = "perms.txt"),
    }
)

