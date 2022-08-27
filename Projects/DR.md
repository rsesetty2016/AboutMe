### Disaster & Recovery Automation

##### Description
The task was to automate D/R for multiple applications. Use Ansible infrastructure to implement the solution. Identity **primary** site and **standby** site automatically, and perform failover when initiated. Synchronize file systems periodically to make sure that all data files and configuration files are in sync. 

---

##### Implementation
1. Capture the key processes that should be running on Primary host.
2. Before D/R, a precheck **playbook** identities the **Primary** and **Standbyhost**
3. Dynamically generates a JSON file that contains the details of the processes to be started on to be  **primary** host, and processes that should be brought down on, to be **standby** host. 