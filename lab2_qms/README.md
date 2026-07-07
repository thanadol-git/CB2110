# Lab 2 (quantms) — Running a DIA proteomics pipeline with quantmsdiann on GitHub Codespaces

In lab 2 you analyzed a table of already-processed mass-spec results. In this lab you will
generate that kind of table yourself, by running the actual
[quantmsdiann](https://github.com/bigbio/quantmsdiann) pipeline (Nextflow + DIA-NN) on
DIA mzML files and a FASTA protein database — no local installation required, everything
runs in a free GitHub Codespace.

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

1. Go to https://github.com/bigbio/quantmsdiann and click **Fork** (top right) so you have your
   own copy to work in and can push/save your work if you want.
2. On your fork, click **Code > Codespaces > Create codespace on master**.
3. If asked to choose a machine type, pick **4-core · 16 GB RAM** — this matches what the
   pipeline's `.devcontainer` expects. Building the container the first time takes a few minutes.

> **Codespaces quota:** a free personal GitHub account gets 120 core-hours/month, which is
> about 30 hours on a 4-core machine — plenty for this lab. Stop or delete your Codespace
> (`Codespaces` tab on github.com) when you're done for the day so you don't burn quota
> sitting idle.

## 2. Get the lab helper files

Once the Codespace terminal is open, pull this lab's helper files from the course repo:

```bash
curl -sL https://raw.githubusercontent.com/thanadol-git/CB2110/main/lab2_qms/download_data.sh -o download_data.sh
curl -sL https://raw.githubusercontent.com/thanadol-git/CB2110/main/lab2_qms/template.sdrf.tsv -o custom.sdrf.tsv
```

## 3. Download the mzML files and FASTA database

Run the helper script (the download links will be announced on Canvas):

```bash
bash download_data.sh
```

This creates a `data/` folder containing your `.mzML` files and the `.fasta` database.

## 4. Fill in the SDRF file

Open `custom.sdrf.tsv` and replace the placeholders (in `<...>`) with your actual sample
details and file paths, e.g. `comment[file uri]` should point at `data/sample1.mzML`
(relative to where you run `nextflow`). Add one row per mzML file. Keep the
`comment[proteomics data acquisition method]` column exactly as
`NT=Data-Independent Acquisition;AC=NCIT:C161786` — that's what tells the pipeline this is
a DIA run.

## 5. Run the pipeline

```bash
nextflow run . \
    -profile docker \
    --input custom.sdrf.tsv \
    --database data/<your_fasta_file>.fasta \
    --outdir results
```

If your Codespace disconnects or the run fails partway through, just re-run the same
command with `-resume` appended — Nextflow will pick up from the last completed step.

If it's slow or you're on a smaller machine, add `--performance_mode true` to trade a small
amount of accuracy for speed/memory.

## 6. Inspect the results

Look inside `results/` for:
- The DIA-NN search report(s)
- An MSstats-format quantification table (similar to what you used in lab 2)
- A MultiQC report summarizing run-level QC metrics

## Questions (draft — to be finalized)

```
1. How many mzML files did you process, and what organism/sample type were they?
2. How many proteins and peptides were identified in total?
3. Pick one QC metric from the MultiQC report and explain what it tells you about run quality.
4. Compare the number of identifications between your two (or more) samples/runs.
5. What does the "Data-Independent Acquisition" SDRF tag actually change in how the
   pipeline processes each file, compared to a DDA run?
```

3 bonus questions and full grading rubric: TBD by instructor.
