# UniTether
A kinda untether, I guess.
# What the..?
Calm down, it's a Substrate tweak. It replaces iOS shutdown functions with its own that don't reload everything, therefore leaving jailbreak patches in the OS. And its subproject "cold" adds a small area **above** SpringBoard, and if it's clicked twice, it makes SpringBoard reload.
# Why "cold" though?
When the iDevice's SpringBoard freezes, well... It **freezes**. And that's why it's "cold". And the "d" is actually "daemon" in short, Apple puts "d" at the end of all iOS daemons.
# How do I compile it?
Clone the repo, get root (either way with **sudo** or **su**) in the prompt, and run **make.sh**
# I'm, um, a regular user. How do I install it?
Add the **artikushg.github.io** repo to Cydia, and install the **UniTether** package.
