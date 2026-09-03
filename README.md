# CB2110

![alt_text](images/header.png)

Welcome to CB2110 labs. Every material for every lab in this course can be found in this repository. We will enjoy proteomics with a bit of coding in `Python` and `R`. If one would like to work with it locally, please try to set up the environment as described below. What we need here is the environment so that you can execute the codes that we provide you during the lab. Nonetheless, it's possible to work on Google Colab without any local installation. Once you finish the exercise, please just upload the worksheet in Canvas where we can grade you with a lot of points there. There usually be 10 questions in each lab with additional 3 bonus questions that can help you with your final grade. Don't worry if you need some help, as we are TAs, we are always available for assistance during the labs. Besides, you can also try it yourself in advance. We will announce through canvas when each lab is ready. Good luck and have fun.

## Labs
Please check the status of each lab here. 

|  Date (Time) | Lab | Submission | Comments | Status |
|:-----|:-----| :--------:| :--------| :-----:|
|7 Sept (13-17)| Lab 1   | `140926`|   `N/A`  | ✅ |
|14 Sept (15-17) | Automation lecture | | | ❌ |
|17 Sept (8-12)| Lab 2   | `240926`|  `N/A`  | ❌ |
|25 Sept (8-12)| Lab 3   | `021026`  | `N/A`  | ❌ |  
|8 Oct (8-12)| Lab 4   | `151026`  | `N/A`  | ❌ |

Usually, the lab will be available 2 days before the session. You are advised to work by yourself. The submission is always 1 week after the lab session. 

---

## Before you start — GitHub account & Student Developer Pack

Some labs (see Option C below) require a GitHub account, so it's best to set this up early.

**1. Create a GitHub account**

- Sign up for free at [github.com/join](https://github.com/join) using your student email if possible (this makes the Student Developer Pack verification in step 2 faster).

**2. (Optional but recommended) Apply for the GitHub Student Developer Pack**

- The [GitHub Student Developer Pack](https://education.github.com/pack) is free for verified students and unlocks extra perks such as additional Codespaces core-hours, GitHub Copilot, Pro-tier repository features, and free credits for other developer tools.
- Apply at [education.github.com/pack](https://education.github.com/pack) using your student ID/school email. Verification can take anywhere from a few minutes to a few days, so apply as soon as possible if you plan to use it.

---

## Option A — Working on Google Colab (Recommended)

No local installation needed. You only need a Google account.

**1. Upload the notebook**

- Go to [Google Colab](https://colab.research.google.com/)
- Click `File > Upload notebook` and upload the `.ipynb` file from the lab folder (e.g. `lab1/lab1.ipynb`)

**2. Install required packages**

At the top of the notebook, add and run a cell to install dependencies:
```python
!pip install pandas numpy matplotlib
```

**3. Work through the lab**

Answer the questions directly in the notebook cells.

**4. Download and submit**

- `File > Download > Download .ipynb` — upload to Canvas
- Or `File > Print > Save as PDF` if a PDF is required

---

## Option B — Working locally with VS Code

### Requirements

1. [VS Code](https://code.visualstudio.com/download)
2. [Conda](https://conda.io/projects/conda/en/latest/user-guide/install/index.html)
3. VS Code extensions: **Python** and **Jupyter** (install from the Extensions panel)

### Steps

**1. Clone the repository**

Open a terminal and run:
```bash
git clone git@github.com:thanadol-git/CB2110.git
cd CB2110
```

You can also find it in the Code/SSH tab on GitHub, or download it directly as a ZIP file.

![alt_text](images/lab0_1.png)

**2. Create the conda environment**

```bash
conda env create -f config_python.yml
```

This creates an environment named `py-cb2110` with Python and all required packages.

**3. Register the Jupyter kernel**

```bash
conda activate py-cb2110
python -m ipykernel install --user --name py-cb2110 --display-name "Python 3 (CB2110)"
```

**4. Open the notebook in VS Code**

- Open VS Code and open the cloned `CB2110` folder (`File > Open Folder`)
- Navigate to the lab folder (e.g. `lab1/`) and open `lab1.ipynb`
- In the top-right corner of the notebook, click **Select Kernel** and choose **Python 3 (CB2110)**
- You can now run cells and answer questions directly in the notebook

**5. Export and submit**

Once finished, export the notebook:
- `File > Export > HTML` — then upload the `.html` file to Canvas

---


## Option C — Running quantmsdiann via GitHub Codespaces (Lab 1 quantms)

For `lab1`, instead of installing Nextflow/Docker locally, you'll run the
[quantmsdiann](https://github.com/bigbio/quantmsdiann) proteomics pipeline in a free
GitHub Codespace.

**Requirements**

- A [GitHub account](https://github.com/join) (free — sign up if you don't already have one).
- Nothing else to install locally: a Codespace is a full Linux dev environment (with
  Nextflow, Docker, and Java preinstalled) that runs in GitHub's cloud and that you access
  either from your browser or from VS Code Desktop. A free personal account includes 120
  core-hours/month of Codespaces usage, which is enough for this lab as long as you stop or
  delete the Codespace when you're done for the day.

See [`lab1/README.md`](lab1/README.md) for full step-by-step instructions (fork the
pipeline repo, open a Codespace, download the mzML/FASTA data, fill in the SDRF template,
and run the pipeline).

---

## Environment files

| File | Language | Environment name | Use for |
|:-----|:---------|:-----------------|:--------|
| `config_python.yml` | Python 3.11 | `py-cb2110` | Lab 0, 2 |
| `config.yml` | R 4.3 | `R-cb2110` | Lab 4 (R/MOFA) |

