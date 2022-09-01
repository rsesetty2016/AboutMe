![implementation_1](../images/Implementation_diagram_1.png)
1. For high performance int Virtualization
   -> Use RAW format for VM images (Qemu - COW/COW2 [Copy on Write])
   -> User "writeback" caching mode for virtual images
2. git config --global credential.helper 'store --file ~/.my-credentials' (On linux to store git credentials)