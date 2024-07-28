#include <linux/kernel.h>
#include <linux/uaccess.h>
#include <linux/slab.h>
#include <linux/sched.h>
#include <linux/module.h>
#include <linux/init.h>

MODULE_LICENSE("GPL");
#define __NR_get_descendants_info 333

struct task_info {
    pid_t pid;
    char state;  
};

void dfs_process_tree(struct task_struct *task, struct task_info *info, size_t *index, size_t size) {
    struct task_struct *child;

    if (*index >= size) {
        pr_err("Info array size exceeded.\n");
        return;
    }

    // Fill in the info array
    info[*index].pid = task->pid;
    info[*index].state = task_state_to_char(task);  
    (*index)++;

    list_for_each_entry(child, &task->children, sibling) {
        dfs_process_tree(child, info, index, size);
    }
}

asmlinkage long sys_get_descendants_info(int pid, struct task_info *info, size_t size) {
    struct task_struct *task = pid_task(find_vpid(pid), PIDTYPE_PID);
    size_t index = 0;
	
    printk(KERN_INFO "sys_get_descendants_info: Received PID: %d\n", pid);
printk(KERN_INFO "sys_get_descendants_info: Size: %zu, Index: %zu\n", size, index);



    if (pid == 1) {
        pr_info("Special handling for PID 1 (init process).\n");
        return 0;  
    }

    if (task == NULL) {
        pr_err("Process with PID %d not found.\n", pid);
        return -ESRCH;
    }

    //pr_info("Process Tree for PID %d:\n", pid);
    printk(KERN_INFO "Process Tree for PID %d:\n", pid);


    // Allocate memory for kernel_info
    struct task_info *kernel_info = kmalloc_array(size, sizeof(struct task_info), GFP_KERNEL);
    if (!kernel_info) {
        pr_err("Failed to allocate memory for kernel_info.\n");
        return -ENOMEM;
    }

    dfs_process_tree(task, kernel_info, &index, size);

    // Use copy_to_user to copy data from kernel to user space
    if (copy_to_user(info, kernel_info, sizeof(struct task_info) * index)) {
        pr_err("Failed to copy data to user space.\n");
        kfree(kernel_info);
        return -EFAULT;
    }

    kfree(kernel_info);

    return index;
}

