##### Key Projects
1. One Click
2. CADIT
3. Firewall Maintenance

##### 1-Click
> ##### Constraints & the Process
> 1. Make sure that no concurrent deployments in the same environment.
> 2. The process should support mulitple environments: Dev, QA, PreProduction and Production.
> 3. Keep track of each task's progress, and rollback in any job fails.
> 4. Fetch all dependencies
> 5. Create required infrastructure: Create user accounts, user quotas, create file systems, update /etc/services, create auto shutdown and startup processes, and oracle database schema.
> 6. Start the processes after installation.
> 7. Involves the following different hosts: Database host, two application servers (clustered), and create SOCKETS on two servers (infrastructue exists), and update configuration on Admin host (single host). Total hosts involved: 1 (DB) + 2 (Apps) + 2 (Ent) + 1 (ADM) = 6 hosts.
> 8. The tasks should be performed in sequential order.
> 9. Send an email with installation details and password for the user.
> 10. Send an email to database team to enable golden gate.



> ###### The Process
> 1. 