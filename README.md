# Directions:

## Part 1 - creating an Ubuntu AMI

-   log into AWS account as the root or a priviledged user able to launch ec2 instances
-   select 'launch ec2'
-   Type 'ubuntu', select the highest LTS (long term support) instance; for me, currently it's `Ubuntu Server 20.04 LTS (HVM), SSD Volume Type - ami-042e8287309f5df03 (64-bit x86) / ami-0b75998a97c952252 (64-bit Arm)`
-   select t2.medium for Instance Type; a minimum of 2 CCPUs are required for running rancher on docker on a single node (https://rancher.com/docs/rancher/v2.x/en/installation/requirements/#hardware-requirements). Note, this is not a free image type.
-   Continue to Add Storage (leaving Configure Instance as defauly). In Add Storage, make sure the Size of your image is 8GiB (the rancher docker image on it's own is 1gb as of 3/22/2021)
-   Continue to Add Tags - add tags if you'd like for organizational purposes. I've tagged my image as name:`ubuntu20_k8s_hw2`
-   Continue to Configure Security Group:
    -   Make sure SSH is open (port 22), you'll need this to SSH into your instance in a bit
    -   open HTTP (port 80)
    -   open HTTPS (port 443)
        HTTP and HTTPS are needed for you to access Rancher on your instance, (after you install it, below) as well for Rancher to talk to it's manager K8s cluster (https://rancher.com/docs/rancher/v2.x/en/installation/requirements/ports/#ports-for-rancher-server-in-docker)
-   Review to make sure that all directions above are set, and create a new key pair - you can name it 'ubuntu20_k8s_hw2'. Download the key, store it somewhere accessible through your terminal, and make sure you don't lose it as you'll have to re-start the process from scrath if you do.

## Part 2 - Settup up the a K8s cluster with Rancher

-   Once your ubtuntu 20 instance is running, ssh into it by running:
    `ssh -i "ubuntu20_k8s_hw2.pem" ubuntu@3.236.9.219`
    'ubuntu20_k8s_hw2.pem' being the private key saved from the last step form part 1
-   once SSHd in your ubuntu AMI, update your dependencies by running:  
     `sudo apt-get update`
-   then, install docker by running:
    `sudo apt install docker.io`
    Type 'Y' and Enter when prompted
-   to make sure docker is installed run:
    `sudo docker -v`
-   if you want to run docker commands without 'sudo', run -
    `sudo usermod -a -G docker ubuntu`
    'ubuntu' in this case being the user of your AMI. Change it to whatever the username of your machine is. To find out who the username of your machine is, in case you don't know, run:
    `whoami`
    Restart your machine after wards by typing:
    `exit`
    and sshing in again:
    `ssh -i "ubuntu20_k8s_hw2.pem" ubuntu@3.236.9.219`
-   to start Rancher at port 80 for http and 443 for https run:
    `docker run -d --restart=unless-stopped \ -p 80:80 -p 443:443 \ --privileged \ rancher/rancher:latest`
    (https://rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/#option-a-default-rancher-generated-self-signed-certificate)
    this will install docker and run it. If you stop this docker image, your cluster setup will also stop and you will have to set up the whole thing again form this point on from scratch.
-   go to your AMI's public IPV4, mine in this case will be:
    https://3.236.9.219
    this action should redirect you to an /update-password url, where you can either set a specific or a randomly generated password for this Rancher cluster. Do NOT lose this password as without it you will have to reset all progress from the previous bullet point (or you simply won't be able to log into your cluster)
    https://3.236.9.219/update-password
    Set Default View\* to use use the current cluster on which Rancher was installed on. Agree to the Terms and COnditions by checking the checkbox and press [Continue]
    Note: You might have to disbaled your antivirus to access the current step as the website is serving on HTTPS without a valid certificate. If yourantivirus is not actively preventing you form this site (get a new one), open google's advanced wranring, and click the Proceed to '3.236.9.219 (unsafe)' link
-   You'll be redirected to the dashboard, click [Clutser Manager] on the top right instead.
-   You might get re-directed to an /update-settings url - Rancher will ask what url to server the cluster from, leave the autocompleted url that it's currently running on, in my case `3.236.9.219` and click [Save URL]
-   at the top right of the /clusters page, click [Add Cluster]
    -   Select [Amazon EC2] as the intrastructure provide from the Create new Kubernetes cluster section
    -   name your cluster, in my case I'll name it
        `hw2manager`
        no capitalization is allowed
-   Select [Add Node Template] from the table. This will bring up an "Add Node Template Modal.
    1. provide your AWS access key* and AWS secret key* credentials to Rancher; if you do not have these - you can follow the directions at (https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys)
       Note: If you are running sensive programs from your AWS root account, create a user that has rights only to the Ubuntu EC2 from which you are running your Rancher image from.
    2. Zone and Network - select the zone and network that your AMI is in, or the closest to your region that Rancher will allow you. For some reason, for me it only allows 'us-west' AZs, even though the AZ of my AMIs are in 'us-east'. Disregard this
    3. Select the vpc - 'vpc-9fffd9e7' or any vpc available to you
    4. select [Next: Select a Security Group], leave the Securty group as the 'Stanrad: Automatically create a `rancher-nodes` group'
    5. select [Next: Set Instance option], allow rancher to create t2.medium instances (it is possible you will be able to get the setup to work by letting rancher create smaller instance, however I haven't tried it yet).
        - reduce the Root Disk Size for these AMIs that will be used as controller/worker nodes to 8gb - that should be sufficient
        - leave the rest as default and click on [Add AWS Tag]
        - optionally add AWS tags to these dynamically created nodes - I tag mine as name:rancherCreatedNodes
    6. Give the Node template a name - I will name mine `Generic Rancher Node Template`, leave the rest as default and click [Create]
-   Name the Node you just created the tempalte for as `Controller`, and check `etcd` as well as `Control Plane` while unchecking `Worker`. For this setup we will be using 2 different nodes - one as the moster and another to controll the replicas.
-   add another Node Poll by clicking [+ Add Node Pool]. Name them as Workers, and leave 'Worker' as checked while making sure that `etcd` and `Control Plane` are unchecked.
-   leave the rest as default and click [Create] at the bottom of the cluster creation screen
-   this will bring you to the global clusters screen, where the last Cluster you've created will be at the top of the table. Wait for it to provision (around 5 minutes)
-   click on your newly created cluster name once it's ready - this will bring you to the monitoring page at /monitoring, then click on the Projects/Namespaces at the top
-   At the projects-namespaces screen, click on [Add Project]; this will bring up an Add Project page
    -   name the project, I will name mine `hw2ClusterInstance`
    -   Optionally give the project a label, this will group your nodes for easy keeping on the next screen - I will name mine `name:hw2Nodes` and then
    -   click [Create]
-   From the top right dropdown, hover over your 'hw2manager' cluster and the click on the 'hw2ClusterInstance' project. This will bring up the /workloads screen
-   at the top right click [Deploy], this will bring up the 'Deploy Workload' screen

    -   name the workload, I will name manine 'hw2Cluster'
    -   Increase the number of pods from 1 to 3
    -   point your pods to a Docker Image, I will be pointing it to the image that conatins my tomcat serving the war from assignment1:
        `thunderspike/645_ejbhtmlsurvey:latest`

        ### Sidebar

        -   If you do not have a docker hub account, create one at https://hub.docker.com/
        -   To create a docker image, you can download docker for whatever OS you're running. Start docker, then create a file called `Dockerfile`.
        -   for the next step, make sure you have a `.war` of a web app you've created with a web java framework.
        -   in the Dockerfile type:

        ```
        FROM tomcat
        COPY app.awr /user/local/tomcat/webapps/
        ```

        the above lines will copy your app.war into the /webapps directory; app.war should be renamed to whatever the name of your war file is. To test that it works, you can build the docker container with:
        `docker build --tag app:latest`, amd then running the conatiner with:
        `docker run -it -p 8888:8080 app:latest` and oppening your browser to localhost:8888/apps or whatever the name of your apps path is.

        -   Finally, after having verified your app is running in your local docker container, and after having created a Dockerhub account, you can push your local container image to the dockerhub so it can be accessible from the cloud. You do that by first logging into your dockerhub with:
            `docker login -u provideYourUsernameHere` and providing the username instead of the string I typed, and then providing the password. Lastly, in order to push your container to dockhub, all you need to do is tag it to live under your dockerhub username you provided in the previous command:
            `docker tag app:latest provideYourUsernameHere/app:latest`. Note tha the first push will take a while. With a that your app will be online.
        -   Returning back to before the sidebar, my personal docker image for this project is named `thunderspike/645_ejbhtmlsurvey:latest`, note that the :latest tag will make it so your image will always point to it's latest version. If you want to version it, you can tag it with the `:` synatax manualy, such as `:v0` or `:v1`

    -   give the Workload a Namespace, I will give the namespace the same tag as the workload - 'hw2Cluster'
    -   click on [+ Add Port], then optionally name the port (I will name mine http)
        -   point it to container port 8080 (as that's where my tomcat container is by default serving the war)
        -   leave 'As a' as NodePort (On every node) by default. This will create configure the Service as a NodePort type
        -   (optionally) change the On Listening port \* to a specific port I will change mine to 32767
    -   leave the rest of the settings as and click [Launch], this will bring you back to the /workloads page and launch your cluster with the sepcified image, and the previously specifid node configuration
    -   wait for the cluster to finish updating, and finally, access the current setup at:
        http://54.191.87.71:32767/645_EJBHtmlSurvey/

## Part 3 - addional pipelining

1. From the top right part of any Rancher screen, hover over the generated user avatar. From there click API & Keys
   From the API & Keys screen, click the [Add Key] button on the top right
    - name your key something like 'rancher-api-key' and click [Create]
    - store your username and password part of the key somewhere, don't lose them or you'll have to create them again from this screen
      Note: anyone with this key is able to spin up any number of AWS instances in your admin's AWS credentils which you shared earlier
2. On the /workloads screen, click on the hamburger tripple dots of you Active cluster on the right (not the namespace), and then click View in API
    - this action will bring you to an api page, note the path: `workloads/deploment:hw2cluster:hw2cluster` the last two tags being :cluster:namespace
    - click on the green [redeploy] button on the top right of the page, this should bring up an 'Action: redeploy' modal. Click on [Show Request] to go to the next modal
    - This will bring you to the 'API Request' modal. NOTE this shows you how to programatically redeploy your application using cURL and HTTP requests:

cURL

```
    curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
    -X POST \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    'https://3.236.9.219/v3/project/c-2bkhh:p-jvpx2/workloads/deployment:hw2cluster:hw2cluster?action=redeploy'
```

HTTP Request:

```
    HTTP/1.1 POST /v3/project/c-2bkhh:p-jvpx2/workloads/deployment:hw2cluster:hw2cluster?action=redeploy
    Host: 3.236.9.219
    Accept: application/json
    Content-Type: application/json
    Content-Length: 2

    { }
```

Note the {CATTLE_ACCESS_KEY} and {CATTLE_SECRET_KEY} are the interloped API Keys stored from the first point of Part 3. You will need these to access this API

3. Log into your dockerhub (my username is thunderspike)

    - click on the username at the top right most of the screen and select 'Account Settings'
    - on the links on the bottom right, click 'Security' and click on [New Access Token]
        - give it a required description name and proceed to the next creen.
        - dockehub will generate a private access token which you can use in place of your password. Store it alongide your rancher api key

4. We've deployed our application publicly unto Github at:
   `https://github.com/Thunderspike/645_Assignment1`
   Note that the name is 645_Assignment1 because this hw is based on the HW1 codebase.

    - On your repo page, click on the rightmost Settings Tab
    - click on Secrets
    - create 3 repo secrets by clicking on the [New repository secret]
        - out first secret is `DOCKERHUB_USERNAME` - it containers the string 'thunderspike' which is the username to my dockerhub
        - second is `DOCKERHUB_TOKEN`, which should contain your dockerhub secret api key from above
        - the third secret is `RANCHER_TOKEN`, which concatinates the `{CATTLE_ACCESS_KEY}:{CATTLE_SECRET_KEY}` from Rancher's API & KEYS page above
    - Most importantly, we've configured Github Actions for this repo

        - You can create your own by including a .yml file (we named ours rancher.yml) in the subdirectory `.github/workflows` in the root of your project. This github action does the following:

            1. It rebuilds the container image `thunderspike/645_ejbhtmlsurvey:latest` everytime there's a push to the `645_Assignment1` repo using the `Dockerfile` in the root path

/_Dockerfile_

```
    FROM tomcat:9.0-jdk15
    LABEL "maintainers"="Pol Ajazi; Amurrio Moya"

    COPY WebContent /root/WebContent/

    RUN cd /root/WebContent && \
    jar -cvf 645_EJBHtmlSurvey.war * && \
    mv 645_EJBHtmlSurvey.war /usr/local/tomcat/webapps/
```

            This Dockerfile copies the /WebContent folder from the Github repo, makes a .war out of it and places it in the /usr/local/tomcat/webapps/ to get served

            2. After the container is re-built, it will restart the Rancher cluster. This restart will cause the cluster to rebuild the pods with the new container (the reason why the `:latest` tag is on every push) and thus automatically deploying our changes.

                - The github actions is running the folloinwg yaml file:

/.github/workflows/_rancher.yml_

```
    name: Rancher Deploy

    on: push

    jobs:
    curl:
        runs-on: ubuntu-latest
        steps:
        - name: Checkout
            uses: actions/checkout@v2

        - name: Set up QEMU
            uses: docker/setup-qemu-action@v1

        - name: Set up Docker Buildx
            uses: docker/setup-buildx-action@v1

        - name: Login to DockerHub
            uses: docker/login-action@v1
            with:
            username: ${{ secrets.DOCKERHUB_USERNAME }}
            password: ${{ secrets.DOCKERHUB_TOKEN }}

        - name: Build and push
            uses: docker/build-push-action@v2
            with:
            context: .
            push: true
            tags: thunderspike/645_ejbhtmlsurvey:latest

        - name: Github Action for curl
            uses: wei/curl@v1.1.1
            with:
            args: >
                -k
                -u "${{ secrets.RANCHER_TOKEN }}"
                -X POST
                -H 'Accept: application/json'
                -H 'Content-Type: application/json'
                https://3.236.9.219/v3/project/c-2bkhh:p-jvpx2/workloads/deployment:hw2cluster:hw2cluster?action=redeploy
```

The result is what was explained in the previous steps. The pseduo code reads as follows:

-   on Checkout of the repo
-   build docker image
-   login on docker hub with credentials, stored on the Github Secrets page
-   push the new image to `thunderspike/645_ejbhtmlsurvey:latest`
-   call curl to redeploy rancher
