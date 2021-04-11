# Virtualbox supports the following modes of networking:

## Bridged 
  - This mode uses the host network adapter directly and allows the guest machine to be in the same subnet as the host machine. It is effectively equivalent to another device being placed on the wireless or wired network as your host. This mode is best for software developers and other users who are not worried about having their work share the same network as their host machines, and is not a good idea for researchers reversing malware or other potentially malicious programs.
## NAT 
  - This mode creates a seperate network for your guest machines by placing it behind a virtual router. DNS and DHCP are all automatically configured but can be modified in the manager settings. Most of the time, you won’t need to customize anything. This mode gives you Internet access, connects your guest machines, but isolates your guest virtual network from the host network. This is the default network mode since it is how your home network is probably configured and is the most familiar to users
## Host-only adapter 
  - Very similar to NAT in terms of functionality for the guests, but now the host can now directly access the guest machines.
# Not attached 
  - No network functionality. The guest machine has no network adapter whatsoever.