# CB2110

![alt_text](images/header.png)

Welcome to CB2110 labs. Every material for every lab in this course can be found in this repository. We will enjoy proteomics with a bit of coding in `Python`. If one would like to work with it locally, please try to set up the environment as described below. What we need here is the environment so that you can execute the codes that we provide you during the lab. Nonetheless, it's possible to work on Google Colab without any local installation. Once you finish the exercise, please just upload the worksheet in Canvas where we can grade you with a lot of points there. There usually be 10 questions in each lab with additional 3 bonus questions that can help you with your final grade. Don't worry if you need some help, as we are TAs, we are always available for assistance during the labs. Besides, you can also try it yourself in advance. We will announce through canvas when each lab is ready. Good luck and have fun.

## LABs
Please check the status of each lab here. 

|  Date (Time) | Lab | Submission | Comments |
|:-----|:-----| :--------:| :--------|
|7 Sept (13-17)| Lab 1   | `140926`|   `N/A`  |
|14 Sept (15-17) | Automation lecture | | |
|17 Sept (8-12)| Lab 2   | `240926`|  `N/A`  |
|25 Sept (8-12)| Lab 3   | `021026`  | `N/A`  |  
|8 Oct (8-12)| Lab 4   | `151026`  | `N/A`  |  

Usually, the lab will be available 2 days before the session. You are advised to work by yourself. The submission is always 1 week after the lab session. 

---

## Option A — Working locally with VS Code

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
- Alternatively, submit the `.ipynb` file directly if Canvas accepts it

---

## Option B — Working on Google Colab

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

## Option C — Running quantmsdiann via GitHub Codespaces (Lab 2 quantms)

For `lab2_qms`, instead of installing Nextflow/Docker locally, you'll run the
[quantmsdiann](https://github.com/bigbio/quantmsdiann) proteomics pipeline in a free
GitHub Codespace. See [`lab2_qms/README.md`](lab2_qms/README.md) for full step-by-step
instructions (fork the pipeline repo, open a Codespace, download the mzML/FASTA data,
fill in the SDRF template, and run the pipeline).

---

## Environment files

| File | Language | Environment name | Use for |
|:-----|:---------|:-----------------|:--------|
| `config_python.yml` | Python 3.11 | `py-cb2110` | Lab 1, 2, 3 |
| `config.yml` | R 4.3 | `R-cb2110` | Lab 4 (R/MOFA) |

