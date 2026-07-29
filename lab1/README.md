# Lab 1 (quantmsdiann) — Running a DIA proteomics pipeline with quantmsdiann on GitHub Codespaces

In lab 0 you analyzed a table of already-processed mass-spec results. In this lab you will
generate that kind of table yourself, by running the actual
[quantmsdiann](https://github.com/bigbio/quantmsdiann) pipeline (Nextflow + DIA-NN) on
DIA mzML files and a FASTA protein database — no local installation required, everything
runs in a free GitHub Codespace.

You'll work with a real DIA SDRF from the [`sdrf/`](sdrf) folder:
[`01_HELA_CERVIX_x_201T_LUNG.sdrf.tsv`](sdrf/01_HELA_CERVIX_x_201T_LUNG.sdrf.tsv), which
pairs 6 DIA runs of **HeLa** (cervix) with 6 DIA runs of **201T** (lung cancer) from the
PXD030304 cell-line proteomics study — 12 mzML files in total. (The `sdrf/` folder has 39
other HeLa-vs-other-organ pairings if your instructor assigns you a different one — check
`sdrf/manifest.tsv` for the full list.)

## Intended learning outcomes (ILOs)

On completion of the lab, the student should be able to:
```
* describe the stages of a DIA (data-independent acquisition) proteomics workflow
* configure an SDRF sample metadata file for a DIA experiment
* execute a Nextflow/nf-core pipeline in a containerized cloud environment
* interpret pipeline QC output and quantification results
```

- Member1:
- Member2:
- Contact email:

---

## 1. Open a Codespace on quantmsdiann

0. You'll need a [GitHub account](https://github.com/join) (free) to fork the repo and
   create a Codespace. If you don't have one yet, sign up before continuing — no payment
   details required for the free tier used in this lab.
1. Go to https://github.com/bigbio/quantmsdiann and click **Fork** (top right) so you have your
   own copy to work in and can push/save your work if you want.
   <img width="1902" height="1033" alt="image" src="https://github.com/user-attachments/assets/f40ea2b1-b15d-4dce-939a-8dbae2fb0049" />

3. On your fork, click **Code > Codespaces > Create codespace on master**.
   <img width="1902" height="1033" alt="image" src="https://github.com/user-attachments/assets/4343fa6d-86e1-4f9a-9f79-c7611358562f" />

4. If asked to choose a machine type, pick **4-core · 16 GB RAM** — this matches the
   `hostRequirements` declared in the pipeline's `.devcontainer/devcontainer.json`.
   - Since this lab runs the pipeline in the background (see step 6), it's worth bumping the
     **idle timeout** up before you create the Codespace, so GitHub doesn't stop the machine
     out from under a run that's still going after you close the tab. Click the **...**
     next to the **Create codespace** button → **New with options...**, and set **Idle
     timeout** to its max (240 minutes / 4 hours). If you forget, you can also raise the
     *default* used for all future Codespaces at
     [github.com/settings/codespaces](https://github.com/settings/codespaces) → **Default
     idle timeout**. Note this only covers inactivity — the pipeline itself can safely run
     past that if you still have the tab or VS Code window open and connected.
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
   → pick your `quantmsdiann` fork and the `master` branch → pick the 4-core/16GB machine
   type.
   - If you already created a Codespace in the browser (step 2 above), instead run
     **Codespaces: Connect to Codespace** and select it from the list — no need to create a
     second one.
4. VS Code Desktop opens a remote window connected to that Codespace; use its integrated
   terminal for every command in this lab exactly as if you were in the browser.

## 2. Get the lab helper files

Once the Codespace terminal is open, pull this lab's helper files from the course repo:

```bash
# Download *,mzML files, be sure that they are in your group
curl -sL https://raw.githubusercontent.com/thanadol-git/CB2110/main/lab1/download_data.sh -o download_data.sh

# Download SDRF, one can also copy from SDRF dir
curl -sL https://raw.githubusercontent.com/thanadol-git/CB2110/main/lab1/sdrf/01_HELA_CERVIX_x_201T_LUNG.sdrf.tsv -o custom.sdrf.tsv

# Download config file to run with full spec
curl -sL https://raw.githubusercontent.com/thanadol-git/CB2110/main/lab1/codespaces.config -o codespaces.config
```

(Swap the SDRF URL for a different file under `sdrf/` if you were assigned another
HeLa-vs-organ pairing.)

## 3. Download the mzML files and FASTA database

`custom.sdrf.tsv` already lists the 12 mzML files this pairing needs (`comment[data file]`
column):

```
190115_9131_004HL_007LQ_M04_S_1.mzML   190124_9131_004O3_0089Y_M04_S_1.mzML
190116_9131_004IH_0082C_M06_S_1.mzML   190118_9131_004IH_00854_M04_S_1.mzML
190115_9131_004HL_007L9_M06_S_1.mzML   191005_B43-T1-13_00DLF_00JCQ_M01_S_1.mzML
190120_9131_004O3_0086J_M06_S_1.mzML   191017_B47-T3-13_00DN7_00KAK_M04_S_1.mzML
191009_B43-T2-13_00DLF_00JG8_M03_S_1.mzML   191008_B47-T1-13_00DN7_00JFO_M01_S_1.mzML
191008_B45-T2-13_00DMB_00JEP_M03_S_1.mzML   191006_B45-T1-13_00DMB_00JD7_M01_S_1.mzML
```

Run the helper script to fetch these plus the FASTA database (the download links will be
announced on Canvas):

```bash
bash download_data.sh
```

This creates a `data/` folder containing your `.mzML` files and the `.fasta` database.

## 4. Point the SDRF at your downloaded files

`custom.sdrf.tsv` already has real sample metadata (organism, instrument, disease, etc.)
for the 6 HeLa + 6 partner-organ runs — you don't need to fill anything in by hand. The
only thing to update is `comment[file uri]`, which currently holds bare filenames (e.g.
`190115_9131_004HL_007LQ_M04_S_1.mzML`); point each one at where `download_data.sh` put the
file, e.g. `data/190115_9131_004HL_007LQ_M04_S_1.mzML` (relative to where you run
`nextflow`). Leave `comment[proteomics data acquisition method]` as
`NT=Data-Independent Acquisition;AC=NCIT:C161786` — that's what tells the pipeline this is
a DIA run.

## 5. (Optional but recommended) Reuse a pre-built spectral library

`INSILICO_LIBRARY_GENERATION` only depends on the FASTA and search parameters — not on your
mzML files — so it's identical for every HeLa-vs-organ pairing in `sdrf/`. If you've already
generated a `.speclib`/`speclib.tsv` (e.g. with the standalone `diann --fasta ... --gen-spec-lib`
command, run locally or in a previous Codespace session), put it in `data/` and pass it in
with `--speclib` so the pipeline skips regenerating it:

```bash
nextflow run . \
    -bg \
    -profile docker \
    -c codespaces.config \
    --input 01_HELA_CERVIX_x_201T_LUNG.sdrf.tsv \
    --database data/human_proteome.fasta \
    --speclib lib.predicted.speclib \
    --outdir results
# Optionally add -resume to continue from previous runs:
#    -resume
```
```

This skips only the fasta-search/prediction step — `PRELIMINARY_ANALYSIS` and
`ASSEMBLE_EMPIRICAL_LIBRARY` still run afterward to calibrate this library against your
actual mzML files, so results are unaffected; you just avoid paying the expensive
in-silico prediction cost more than once.

## 6. Run the pipeline

This pipeline can take longer than you'll want to keep a browser tab open and watching, so
run it with Nextflow's `-bg` flag to detach it into the background. If you don't have a
pre-built `.speclib` yet, just drop `--speclib data/speclib.tsv` from the command below:

```bash
nextflow run . \
    -bg \
    -profile docker \
    -c codespaces.config \
    --input custom.sdrf.tsv \
    --database data/human_proteome.fasta \
    --outdir results \
    -resume
```

`-bg` detaches the run from your terminal and writes everything to `.nextflow.log` instead of
printing a live progress bar — the command returns immediately, and the pipeline keeps running
even if you close the tab or your connection drops (as long as the Codespace itself is still
running — see the idle timeout note in step 1). To check on it later:

```bash
# Follow the log live
tail -f .nextflow.log

# Confirm the Nextflow process is still alive
ps aux | grep nextflow

# Per-process status/timing once a few steps have finished
cat results/pipeline_info/execution_trace.txt
```

`codespaces.config` caps every process to 4 CPUs / 14 GB — without it, some steps (labelled
`process_medium` in the pipeline) request 8 CPUs and will fail with
`Process requirement exceeds available CPUs -- req: 8; avail: 4` on the standard Codespaces
machine. It also turns on the `execution_report.html`/`execution_trace.txt`/
`execution_timeline.html` files under `results/pipeline_info/`, which is what you'll want to
check for progress and timing since `-bg` mode has no live progress bar.

`-resume` is included above so it's always safe to re-run this exact command — on a fresh
run it has no effect, but if your Codespace disconnects or a step fails partway through,
Nextflow will pick up from the last completed step instead of starting over.

If it's slow or you're on a smaller machine, add `--performance_mode true` to trade a small
amount of accuracy for speed/memory.

## 7. Inspect the results

Look inside `results/` for:
- The DIA-NN search report(s)
- An MSstats-format quantification table (similar to what you'll use in lab 2)
- A MultiQC report summarizing run-level QC metrics

## Questions (draft — to be finalized)

```
1. Which two cell lines/organs did you compare, and how many mzML files came from each?
2. How many proteins and peptides were identified in total?
3. Pick one QC metric from the MultiQC report and explain what it tells you about run quality.
4. Compare the number of identifications between the two cell lines — are there differences,
   and what might explain them biologically?
5. What does the "Data-Independent Acquisition" SDRF tag actually change in how the
   pipeline processes each file, compared to a DDA run?
```

3 bonus questions and full grading rubric: TBD by instructor.
