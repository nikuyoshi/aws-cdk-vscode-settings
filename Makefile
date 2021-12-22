cdk-app-folder = hoge
region = us-west-2

install-dependencies:
	ncu -u --packageFile $(cdk-app-folder)/package.json
	npm install --prefix $(cdk-app-folder)

build:
	@[ "${target}" ] || ( echo ">> target is not set. Please check your argument. ex. make build target=$(cdk-app-folder). "; exit 1 )	
	npm run build --prefix $(target)

test:
	@[ "${target}" ] || ( echo ">> target is not set. Please check your argument. ex. make test target=$(cdk-app-folder). "; exit 1 )	
	npm test --prefix $(target)

synth:
	@[ "${target}" ] || ( echo ">> target is not set. Please check your argument. ex. make synth env=dev target=$(cdk-app-folder) "; exit 1 )	
	@[ "${env}" ] || ( echo ">> env is not set. Please check your argument. ex. make synth env=dev target=$(cdk-app-folder) "; exit 1 )	
	cd $(target) && cdk synth -c env=${env} --output=cdk.out/${env}/${target}

deploy-all:
	@[ "${target}" ] || ( echo ">> target is not set. Please check your argument. ex. make deploy-all target=$(cdk-app-folder) env=dev"; exit 1 )	
	@[ "${env}" ] || ( echo ">> env is not set. Please check your argument. ex. make deploy-all target=$(cdk-app-folder) env=dev"; exit 1 )	
	cd $(target) && cdk deploy -c env=${env} --all

diff:
	@[ "${target}" ] || ( echo ">> target is not set. Please check your argument. ex. make diff target=$(cdk-app-folder) env=dev"; exit 1 )	
	@[ "${env}" ] || ( echo ">> env is not set. Please check your argument. ex. make diff target=$(cdk-app-folder) env=dev"; exit 1 )	
	cd $(target) && cdk diff -c env=$(env)

destroy-all:
	@[ "${target}" ] || ( echo ">> target is not set. Please check your argument. ex. make destroy-all target=$(cdk-app-folder) env=devmake deploy target=$(cdk-app-folder) env=dev region=$(region)"; exit 1 )	
	@[ "${env}" ] || ( echo ">> env is not set. Please check your argument. ex. make destroy-all env=dev"; exit 1 )	
	cd $(target) && cdk destroy -c env=$(env) --all

bootstrap:
	@[ "${account}" ] || ( echo ">> account is not set. Please check your argument. ex. make bootstrap account=123456789012 region=$(region) env=dev"; exit 1 )	
	@[ "${region}" ] || ( echo ">> region is not set. Please check your argument. ex. make bootstrap account=123456789012 region=$(region) env=dev"; exit 1 )	
	@[ "${env}" ] || ( echo ">> env is not set. Please check your argument. ex. make bootstrap account=123456789012 region=$(region) env=dev"; exit 1 )	
	cdk bootstrap aws://${account}/${region} -c env=${env}