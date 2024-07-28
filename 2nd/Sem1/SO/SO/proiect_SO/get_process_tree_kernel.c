#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/syscalls.h>

MODULE_LICENSE("GPL");

extern long (*sysptr)(int pid);

static int __init init_sys_get_process_tree(void) {
    sysptr = sys_get_process_tree;
    return 0;
}

static void __exit exit_sys_get_process_tree(void) {
    if (sysptr != NULL)
        sysptr = NULL;
}

module_init(init_sys_get_process_tree);
module_exit(exit_sys_get_process_tree);

