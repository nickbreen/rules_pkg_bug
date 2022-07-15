exports_files(["test.sh"])

sh_test(
    name = "anti-test/mkdirs-makes-no-difference-to-files",
    srcs = [":test.sh"],
    args = ["$(location //just_files:perms/files)", "$(location //with_mkdirs:perms/files)"],
    data = ["//just_files:perms/files", "//with_mkdirs:perms/files"],
)

sh_test(
    name = "anti-test/mkdirs-makes-no-difference-to-tar",
    srcs = [":test.sh"],
    args = ["$(location //just_files:perms/tar)", "$(location //with_mkdirs:perms/tar)"],
    data = ["//just_files:perms/tar", "//with_mkdirs:perms/tar"],
)
