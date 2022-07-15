load("@rules_pkg//pkg:mappings.bzl", "pkg_files", "pkg_mkdirs")
load("@rules_pkg//pkg:tar.bzl", "pkg_tar")
load("//:rule.bzl", "tree_artifact_rule")

tree_artifact_rule(name = "tree", dir = "foo.d")

pkg_files(name = "files", srcs = [":tree"])
pkg_mkdirs(name = "dirs", dirs = ["foo.d/bar"])

pkg_tar(name = "tar", srcs = [":files", ":dirs"])

filegroup(
    name = "expected-perms",
    srcs = [":tree"],
    output_group = "perms",
)

genrule(
    name = "perms/tar",
    outs = ["perms.tar.txt"],
    srcs = [":tar"],
    cmd = """
    echo "Apparently the file permissions from the rule have been overridden (ignoring umask):"
    tar tvf $< | awk '{ print $$1, "/" $$6 }' | tee $@
    """,
)

genrule(
    name = "perms/files",
    outs = ["perms.files.txt"],
    srcs = [":files"],
    cmd = """ find -L $(SRCS) -type d -printf "%M %p/\n" -o  -printf "%M %p\n" | sed 's!$(RULEDIR)!!' | tee $@ """,
)

sh_test(
    name = "tar-has-expected-perms",
    srcs = ["//:test.sh"],
    args = ["$(location :expected-perms)", "$(location :perms/tar)"],
    data = [":expected-perms", ":perms/tar"]
)

sh_test(
    name = "files-have-expected-perms",
    srcs = ["//:test.sh"],
    args = ["$(location :expected-perms)", "$(location :perms/files)"],
    data = [":expected-perms", ":perms/files"]
)
