# Spotify Analysis

This project contains a Python package for analyzing and visualizing Spotify track data to discover relationships between track features and popularity.

## Description

The `spotify_analysis` package includes modules for loading, cleaning, and visualizing Spotify dataset. It focuses on showing the relationship between the 'liveness' of a track and its popularity, categorized by release year.

## Prerequisites

Before you continue, ensure you meet the following requirements:

* You have installed the latest version of [Python](https://www.python.org/downloads/) (Python 3.8+ recommended).
* You have a `<Windows/Linux/Mac>` machine. State which OS is supported/required.

## Environment Setup

To run this project, you will need to set up a virtual environment and install its dependencies.

```bash
git clone git@bitbucket.org:psyc46050/spotify_analysis.git
cd spotify_analysis
conda env create -f env_spotify.yml
conda activate spotify_analysis
pip install .
```

## Usage

After installing the `spotify_analysis` package and activating the environment, you can start analyzing your Spotify data by importing the package in your Python scripts or interactive sessions.
