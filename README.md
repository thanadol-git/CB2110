# CB2110

Welcome to the lab session. Every materials for every labs in this  course can be found here. Please try to set up the environment that you have here as you need it for every lab in this course. What we need here is the environment so that you can execute the codes that we provide you during the lab. You will also be able to code some parts of them yourself. Once you finish answering the questions, you will just need to export the pdf file and upload them to Canvas where we can grade you with a lot of points there. There usually are 10 questions in each labs with additional 3 bonus questions that can help you with your final grade. This will definitely a fun session so that you can enjoy and indulge with proteomics much better with a bit of codings. Don't worry if you need some helps, we are always helping you in the labs. Besides, you can also try it yourself in advance. We will announce through canvas when each lab is ready. Good luck and have fun.  

## Downloads
There are two softwares that we require for this course. Please follow the instructions below to download them.

1. [VS Code](https://code.visualstudio.com/download) 
2. [Conda](https://conda.io/projects/conda/en/latest/user-guide/install/index.html) 

## Steps 
Here we will show you how to setup the environment for this course. EVvery lab is base on R language and we will execute them through VScode with Conda environment. Please follow the instruction here for conda installation and then follow the instruction for VScode installation. 

1. Open your vscode. 

2. Clone this github repository to your local. Open terminal and change the directory to your local computer of choice. Run this command. 

```
git clone <github repo link>
```
 
In this case the link should be `git@github.com:thanadol-git/CB2110.git`. You can also find it in the code/ssh tab. Similarly, you can basically download it directly from the github page in zip file.
![alt_text](images/lab0_1.png)



3. Set up conda environment. 
```
conda env create -f config.yml
```

4. Now, you should have installed this environment with the name `R-cb2110`. You can list your env with: 
```
conda env list 
```
5. Activate the environment. 
```
conda activate R-cb2110
```
6. Now, you have the environment ready. You should be able to work with every labs in this course. 

## For every labs
1. Activate your environment. 
2. Open the markdown file in the lab folder.
3. Answer the questions in the markdown file. 
4. Export the file to pdf.
5. Submit the pdf file to Canvas.