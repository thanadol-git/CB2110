# Quick Start: sdrf-skills

## 1. Clone and setup
Go to [github.com/bigbio/sdrf-skills](https://github.com/bigbio/sdrf-skills).

Clone the repo (with submodules!) and get into the folder:
```bash
git clone --recurse-submodules https://github.com/bigbio/sdrf-skills.git
cd sdrf-skills
```
If submodules are missing:  
```bash
git submodule update --init --recursive
```

## 2. Install tools

You need Python 3.10+ and `parse_sdrf`.  
With conda (recommended for Thermo .raw files):
```bash
conda env create -f environment.yml
conda activate sdrf-skills
```
Or with pip:
```bash
python3 -m venv .venv
source .venv/bin/activate  # On Windows use .venv\Scripts\activate
pip install -r requirements.txt
```

Test it:
```bash
parse_sdrf --version
```

## 3. Use with your assistant

Open the cloned folder in your preferred AI assistant (Cursor, Claude, etc.).  
Always work from the repo root.  
- For Cursor: open the folder, use "Agent chat", and give direct instructions (“Annotate PXD...” or “Validate annotations/…”).
- For Claude: from the repo directory, use commands like `/sdrf:annotate PXD012345`.

## 4. Common Tasks

- **Setup tools:** “Set up SDRF skills”
- **Annotate a dataset:** “Annotate PXD012345”
- **Validate file:** “Validate annotations/PXD012345.sdrf.tsv”
- **Contribute a file:** “Contribute PXD012345”

## 5. Files & Folders

- `scratchpad/<PXD>/` - workspace for each dataset
- `annotations/<PXD>.sdrf.tsv` - draft SDRF file
- `datasets/<PXD>/` (in sdrf-annotated-datasets) - community version

## 6. Important rules

- Don’t guess ontology accessions.
- Use “not available” or “not applicable” as reserved words, not “NA”.
- Never approve your own SDRF file for contribution.

## 7. Creating a Pull Request (PR) for Annotated Data

To contribute your annotated SDRF data back to the community repository, you need to submit a Pull Request (PR) via GitHub. Follow these steps:

1. **Fork the Repository**
   - Go to the original GitHub repository (e.g., `sdrf-annotated-datasets` or this lab repo).
   - Click on the "Fork" button in the top right to create your own copy.

2. **Create a New Branch**
   - In your local clone of the forked repo, create a branch for your contribution:
     ```bash
     git checkout -b add-PXD<your_dataset>
     ```
     Replace `<your_dataset>` with the actual dataset ID, e.g., `add-PXD012345`.

3. **Add Your Annotated File**
   - Move your annotated SDRF file, e.g., `PXD012345.sdrf.tsv`, into the `annotations/` folder of your repo.
   - Optionally, add any notes or additional files in a new folder under `scratchpad/`.

4. **Commit Your Changes**
   - Stage and commit your files:
     ```bash
     git add annotations/PXD012345.sdrf.tsv
     git commit -m "Add annotated SDRF for PXD012345"
     ```

5. **Push to Your Fork**
   - Push your branch to your own GitHub fork:
     ```bash
     git push origin add-PXD012345
     ```

6. **Open a Pull Request**
   - Go to your fork on GitHub.
   - You’ll see a prompt to “Compare & pull request” for your newly pushed branch—click that.
   - Fill out the PR form:
     - **Title:** Describe what you’re submitting (e.g., "Add annotated SDRF for PXD012345").
     - **Description:** State which dataset you’re contributing, mention any specifics or questions, and highlight anything needing review.
   - Submit the PR to the original (upstream) repository.

7. **Respond to Reviews**
   - If maintainers ask questions or request changes, address their comments and push more commits to your branch as needed.

**Tips:**
- Ensure your annotation follows formatting and ontology rules (see above).
- Never approve your own file for contribution—wait for a review from a different annotator.
- You can include supporting scripts or QC plots if they help reviewers but keep the main SDRF annotation clean.

For detailed, step-by-step visuals, see the [GitHub documentation on creating pull requests](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request).

If you have questions or trouble, ask a TA or post in the course forum/Slack.

If you encounter missing tools or files, verify that all git submodules are updated (`git submodule update --init --recursive`) and your Python environment is correctly set up and activated.

For additional details or troubleshooting, refer to the repository documentation.
