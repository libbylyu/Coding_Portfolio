import setuptools

setuptools.setup(
    name="spotify_analysis",
    version="0.1.0",
    author="Libby Lyu, Xiaoya Huang, Yvette Yang",
    author_email="wanzlyu@uchicago.edu, xh42@uchicago.edu, zaiying@uchicago.edu",
    description="Data pipeline assignment for PSYC46050",
    packages=setuptools.find_packages(),
    install_requires=[
        'pandas',
        'matplotlib',
        'bokeh==2.2.2',
        'seaborn',
        'plotly.express'
    ],
)
