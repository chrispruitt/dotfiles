# Install cool tools! #######################################################################################################################################

echo Installing Cool AWS tools
# get-ssm-params - https://github.com/justmiles/go-get-ssm-params

echo ssm-get-params
curl -f -L https://github.com/justmiles/go-get-ssm-params/releases/download/v1.7.0/get-ssm-params.v1.7.0.darwin-amd64 -o /usr/local/bin/get-ssm-params
chmod +x /usr/local/bin/get-ssm-params

# ecs-deploy - https://github.com/justmiles/ecs-deploy
# TODO

#mkdir ecs_justmiles
#curl -f -LO https://github.com/justmiles/ecs-cli/releases/download/v0.0.11/ecs_0.0.11_Darwin_x86_64.tar.gz | tar xvzf -C ecs_justmiles
#mv ecs_justmiles/ecs /usr/local/bin/
#chmod +x /usr/local/bin/ecs
#rm -r ecs_justmiles

echo get-ecs-services
curl -f -L https://github.com/chrispruitt/go-get-ecs-services/releases/download/v1.3.0/get-ecs-services.v1.3.0.darwin-amd64 -o /usr/local/bin/get-ecs-services
chmod +x /usr/local/bin/get-ecs-services

echo get-ecs-power
curl -f -L https://github.com/chrispruitt/ecs-power/releases/download/v0.0.4/ecs-power_0.0.4_Darwin_x86_64.tar.gz | tar -xz -C /usr/local/bin/
chmod +x /usr/local/bin/ecs-power

echo git-bump
curl -f -L https://github.com/b4b4r07/git-bump/releases/download/v0.1.0/git-bump_darwin_x86_64.tar.gz | tar -xz -C /usr/local/bin/
chmod +x /usr/local/bin/git-bump
#############################################################################################################################################################
