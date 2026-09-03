# Lab 1 (quantmsdiann) — Running a DIA proteomics pipeline with quantmsdiann on GitHub Codespaces

## Intended learning outcomes (ILOs)

On completion of the lab, the student should be able to:

* describe the stages of a DIA (data-independent acquisition) proteomics workflow
* configure an SDRF sample metadata file for a DIA experiment
* execute a Nextflow/nf-core pipeline in a containerized cloud environment
* interpret pipeline QC output and quantification results

---

## 1. Open a Codespace on quantmsdiann

1. You'll need a [GitHub account](https://github.com/join) (free) to fork the repo and
   create a Codespace. If you don't have one yet, sign up before continuing — no payment
   details required for the free tier used in this lab.
2. Go to https://github.com/bigbio/quantmsdiann and click **Fork** (top right) so you have your
   own copy to work in and can push/save your work if you want.
   <img width="1902" height="1033" alt="image" src="https://github.com/user-attachments/assets/f40ea2b1-b15d-4dce-939a-8dbae2fb0049" />

3. On your fork, click **Code > Codespaces > Create codespace on main**.
   <img width="1902" height="1033" alt="image" src="https://github.com/user-attachments/assets/4343fa6d-86e1-4f9a-9f79-c7611358562f" />

4. If asked to choose a machine type, pick **4-core · 16 GB RAM** — this matches the
   `hostRequirements` declared in the pipeline's `.devcontainer/devcontainer.json`.
5. Wait for the container to build. The devcontainer is based on `nfcore/devcontainer:latest`,
   which already ships with Nextflow, Docker, and Java preinstalled, so there's nothing to
   install or pre-pull yourself — GitHub builds it automatically the first time you open the
   Codespace (a few minutes). The individual pipeline step containers (DIA-NN, etc.) are
   separate again and get pulled automatically, one at a time, when `nextflow run` actually
   reaches each step — not something you need to fetch in advance.

> **Codespaces quota:** a free personal GitHub account gets 120 core-hours/month, which is
> about 30 hours on a 4-core machine — plenty for this lab. Stop or delete your Codespace
> (`Codespaces` tab on github.com) when you're done for the day so you don't burn quota
> sitting idle.

### Optional: work from VS Code Desktop instead of the browser

The Codespace still runs remotely on GitHub's servers either way — this just changes which
editor you drive it from.

1. Install the **GitHub Codespaces** extension in your local VS Code (Extensions panel,
   search "GitHub Codespaces").
2. Sign in to GitHub when prompted (top-left Accounts icon, or the extension will prompt you).
3. Open the Command Palette (`Ctrl/Cmd+Shift+P`) and run **Codespaces: Create New Codespace**
   → pick your `quantmsdiann` fork and the `main` branch → pick the 4-core/16GB machine
   type.
   - If you already created a Codespace in the browser (step 2 above), instead run
     **Codespaces: Connect to Codespace** and select it from the list — no need to create a
     second one.
4. VS Code Desktop opens a remote window connected to that Codespace; use its integrated
   terminal for every command in this lab exactly as if you were in the browser.

## 2. Copy MS raw files from the USB drive

Each of you is assigned a project number (for example, Thanadol is `1`). Get the USB drive
from the class — Fredrik or a TA will hand it to you in person. Inside it, find the folder
matching your project number and copy everything to your local computer, then to your
Codespace. The name-to-project-number mapping is in [`student_group_2026.csv`](student_group_2026.csv).
The files should look like this:

```
190115_9131_004HL_007LQ_M04_S_1.mzML   190124_9131_004O3_0089Y_M04_S_1.mzML
190116_9131_004IH_0082C_M06_S_1.mzML   190118_9131_004IH_00854_M04_S_1.mzML
190115_9131_004HL_007L9_M06_S_1.mzML   191005_B43-T1-13_00DLF_00JCQ_M01_S_1.mzML
190120_9131_004O3_0086J_M06_S_1.mzML   191017_B47-T3-13_00DN7_00KAK_M04_S_1.mzML
191009_B43-T2-13_00DLF_00JG8_M03_S_1.mzML   191008_B47-T1-13_00DN7_00JFO_M01_S_1.mzML
191008_B45-T2-13_00DMB_00JEP_M03_S_1.mzML   191006_B45-T1-13_00DMB_00JD7_M01_S_1.mzML
```

## 3. Get the lab helper files

Once the Codespace terminal is open, pull this lab's helper files from the course repo:

```bash
# Download *.mzML files, be sure they are from your group
curl -sL https://raw.githubusercontent.com/thanadol-git/CB2110/main/lab1/download_data.sh -o download_data.sh

# Download config file to run with full spec
curl -sL https://raw.githubusercontent.com/thanadol-git/CB2110/main/lab1/codespaces.config -o codespaces.config
```

## 4. Download the mzML files and FASTA database

At this point, please look at the SDRF file and the .mzML files. You should find the file names according to the `comment[data file]` column.

Run the helper script to fetch additional files including proteome sequences and spectral library.

```bash
bash download_data.sh
```

## 5. Run the pipeline

Once you have downloaded everything above, you should be ready to run the proteomics analysis pipeline. Please just follow the script below but check your path accordingly (I might have tricked you somehow here).

```bash
nextflow run . \
    -profile docker \
    -c codespaces.config \
    --input 01_HELA_CERVIX_x_201T_LUNG.sdrf.tsv \
    --database data/human_proteome.fasta \
    --speclib lib.predicted.speclib \
    --outdir results \
    -resume
```

- `-profile docker` — use the Docker execution engine.
- `-c codespaces.config` — caps every process at the 4 CPUs / 14 GB a standard Codespaces
  machine actually has. Without it, some steps (labelled `process_medium` in the pipeline)
  request 8 CPUs and will fail with
  `Process requirement exceeds available CPUs -- req: 8; avail: 4`.
- `--input` — your SDRF file.
- `--database` — the proteome FASTA.
- `--speclib` — the spectral library generated from the proteome sequences.
- `--outdir` — where results are written.
- `-resume` — always safe to include: on a fresh run it has no effect, but if your
  Codespace disconnects or a step fails partway through, Nextflow picks up from the last
  completed step instead of starting over.

Having the spectral library only skips the FASTA-search/prediction step — `PRELIMINARY_ANALYSIS`
and `ASSEMBLE_EMPIRICAL_LIBRARY` still run afterward to calibrate this library against your
actual mzML files, so results are unaffected; you just avoid paying the expensive in-silico
prediction cost more than once. If you don't have a pre-built `.speclib` yet, just drop
`--speclib data/speclib.tsv` from the command above.

If it's slow or you're on a smaller machine, add `--performance_mode true` to trade a small
amount of accuracy for speed/memory.

## 6. Inspect the results

Look inside `results/` for:
- The DIA-NN search report(s)
- An MSstats-format quantification table (similar to what you'll use in lab 2)
- A MultiQC report summarizing run-level QC metrics

If you see all of the results here, please upload the MultiQC report to [Canvas](https://canvas.kth.se). Hope you have a great time working on this lab!