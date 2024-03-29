Getting a Paperspace API Key
============================
Login to Paperspace with your account via https://console.paperspace.com/login. It's up to you whether or not you want to log in with Google or use your email address. Either work just fine.

Under your user account, choose **Team Settings**.

![Paperspace User Settings](images/paperspace-user-settings.png)

This will display the **API Keys** tab in your private workspace.
1. Click on the **API Keys** tab.
2. Click on the **Add** button.
3. Enter in a name for your API Key. Suggestion is the form <username>-<machine> (e.g. `taylor-laptop`).
4. Copy the API key to your clipboard.

![Paperspace API Key](images/paperspace-api-key.png)
  
Export the API Key as the environment variable `PAPERSPACE_API_KEY` in your `~/.bashrc`. It is suggested that you used the `~/.bashrc.d` pattern to manage this environment variable.
  
```bash
# Add the following section to the end of your ~/.bashrc
...
for config in ~/.bashrc.d/*.sh; do
    source $config
done
unset config

# Create a ~/.bashrc.d directory
$ mkdir ~/.bashrc.d

# Create the following script:
$ tee ~/.bashrc.d/140.paperspace.sh<<EOF
#!/bin/bash

export PAPERSPACE_API_KEY=<your_api_key>
EOF
```

If you need to switch between multiple Paperspace API keys, you may want to make use of the [direnv tool](https://manpages.ubuntu.com/manpages/xenial/en/man1/direnv.1.html) and create a `.envrc` file
in the directory that contains the related automation code:
```bash
# Create .envrc file with different api from ~/.bashrc.d
export PAPERSPACE_API_KEY=<other_api_key>
```
