#include <linux/kernel.h>
#include <linux/syscalls.h>
#include <linux/sched.h>

MODULE_LICENSE("GPL");

asmlinkage long (*original_sys_get_process_tree)(int pid);

static void dfs_process_tree(struct task_struct *task, int level) {
    struct task_struct *child;

    pr_info("%*sPID: %d, State: %s, Command: %s\n", level * 2, "", task->pid,
            task_is_running(task) ? "Running" : "Not Running", task->comm);

    list_for_each_entry(child, &task->children, sibling) {
        dfs_process_tree(child, level + 1);
    }
}



asmlinkage long my_sys_get_process_tree(int pid) {
    struct task_struct *task;

    pr_info("Process Tree for PID %d:\n", pid);

    task = pid_task(find_vpid(pid), PIDTYPE_PID);

    if (task == NULL) {
        pr_err("Process with PID %d not found.\n", pid);
        return -ESRCH;  // Error code for "No such process"
    }

    dfs_process_tree(task, 0);

    return 0;  // Success
}

static int __init init_sys_get_process_tree(void) {
    original_sys_get_process_tree = sys_call_table[__NR_get_process_tree];
    sys_call_table[__NR_get_process_tree] = my_sys_get_process_tree;
    return 0;
}

static void __exit exit_sys_get_process_tree(void) {
    sys_call_table[__NR_get_process_tree] = original_sys_get_process_tree;
}

module_init(init_sys_get_process_tree);
module_exit(exit_sys_get_process_tree);
