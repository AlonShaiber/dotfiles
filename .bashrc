# let's start by making sure we have the latest dotfiles
yadm pull

# find by typing `uname -n`
nygcbook="ASHAIBER01"
macbook="Alons-MBP"
mski_server="mskilab01.c.nygenome.org"
mski_server2="mskilab02.c.nygenome.org"
immunaibook="Immunai-MB02.local"
dev="dev-alon"

# -----------------------------------------------------------------------------
# SHARED BY ALL {{{
# -----------------------------------------------------------------------------

# if you're scp-ing, we're done
if [ -z "$PS1" ]; then
    return
fi

# Define your aliases here ...
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Define your aliases here ...
if [ -f ~/.bash_utils ]; then
    source ~/.bash_utils
fi

if [ "$SHELL" != "/bin/zsh" ]; then
    # autocorrects small mistakes
    shopt -s cdspell
fi

if [ "$SHELL" = "/bin/zsh" ]; then
    # make fg behave as in bash
    # taken from: https://superuser.com/a/991249 with thanks to meuh
    fg(){ if [[ "$*" =~ ^[0-9]+$ ]]; then builtin fg %"$*";else builtin fg "$@";fi }
fi

# ls coloring
export CLICOLOR=1
export LSCOLORS=gxhxCxDxBxegedabagaced


# -----------------------------------------------------------------------------
# }}} IMMUNAI MACBOOK {{{
# -----------------------------------------------------------------------------
if [[ "$immunaibook" =~ "$(uname -n)" ]]; then
    echo "Hello"
    source .immunairc

    alias python=/usr/local/bin/python3

    export PATH=/Library/Frameworks/Python.framework/Versions/3.7/bin:$PATH

fi

# -----------------------------------------------------------------------------
# }}} Immunai dev VM {{{
# -----------------------------------------------------------------------------
if [[ "$dev" =~ "$(uname -n)" ]]; then
    echo "Hello"
    export PATH="/usr/lib/google-cloud-sdk/bin/:${PATH}"
    export EXTERNAL_GIT_DIR="${HOME}/immunai-product"
    alias rstud="RSTUDIO_PORT=9123 EXTERNAL_GIT_DIR="${HOME}/immunai-product" EXTERNAL_DATA_DIR="${HOME}/data" immunai-product/modules/containers/docker_root/analysis/bin/start-rstudio"
    alias cont="EXTERNAL_GIT_DIR="${HOME}/immunai-product" EXTERNAL_DATA_DIR="${HOME}/data" immunai-product/modules/containers/docker_root/analysis/bin/start-container"
fi

# -----------------------------------------------------------------------------
# }}} NYGC MACBOOK {{{
# -----------------------------------------------------------------------------
if [[ "$nygcbook" =~ "$(uname -n)" ]]; then
    echo "Hello"
    nygcbooksetup
    mskisetup
    merenlabsetup

    export PATH=/usr/local/sbin:${PATH}
    export PATH=${PATH}:/Users/ashaiber/Library/Python/3.7/bin
    export PATH=${PATH}:/Users/ashaiber/software/miniconda3/bin
fi
# -----------------------------------------------------------------------------
# }}} MY MACBOOK {{{
# -----------------------------------------------------------------------------

if [[ $(uname -n) == *"$macbook"* ]]; then

    macsetup
    mskisetup
    merenlabsetup

    MY_R_LIBS="/Library/Frameworks/R.framework/Versions/3.6/Resources/library"
    if [ -n $R_LIBS ]; then
       export R_LIBS=$MY_R_LIBS:$R_LIBS
    else
       export R_LIBS=$MY_R_LIBS
    fi

    # I added this for MacPorts (to my understanding it was supposed to be added automatically, but it wasn't)
    # for more information, visit https://guide.macports.org/chunked/installing.shell.html. without this Macport doesn't work
    # export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

    # alias for python (so python referes to python3
    #alias python='python3'

    ## Add MyScripts to the path
    ## MyScripts is where I keep random standalone scripts
    export PATH=$PATH:/Users/alonshaiber/MyScripts

    # path to medusa
    export PATH=$PATH:/Users/alonshaiber/github/medusa
    export PATH=$PATH:/Users/alonshaiber/github/medusa/medusa_scripts

    # CENTRIFUGE - updating path to also point to centrifuge
    export CENTRIFUGE_BASE="/usr/local/centrifuge"
    export PATH=$PATH:$CENTRIFUGE_BASE/centrifuge

    # updating environment variables (after installing anvio: http://merenlab.org/2016/06/26/installation-v2/#installation-for-developers-youre-a-wizard-arry)
    #export PYTHONPATH=$PYTHONPATH:~/github/anvio/
    #export PATH=$PATH:~/github/anvio/bin:~/github/anvio/sandbox

    # updating path to include Metagenome-profile
    export PATH=$PATH:~/github/Metagenome-profile


    # Adding MUMmer3.23 to the path
    export PATH=$PATH:/Users/alonshaiber/MyLibraries/MUMmer3.23

    # apache-ant
    export ANT_HOME=/usr/local/apache-ant-1.9.7
    export PATH=$PATH:$ANT_HOME/bin

    # JAVA JDK
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_101.jdk/Contents/Home

    # bowtie2
    export PATH=$PATH:~/MyLibraries/bowtie2-2.2.9
    export BT2_HOME="/Users/alonshaiber/MyLibraries/bowtie2-2.2.9"

    # Metaphlan2
    export PATH=$PATH:/Users/alonshaiber/MyLibraries/biobakery-metaphlan2-ec7727ff1875
    export mpa_dir=/Users/alonshaiber/MyLibraries/biobakery-metaphlan2-ec7727ff1875

    # bwa
    export PATH=$PATH:/Users/alonshaiber/MyLibraries/bwa-0.7.12

    # Bandage
    export PATH=$PATH:/Users/alonshaiber/Downloads/Bandage_Mac_v0_8_0/Bandage.app/Contents/MacOS/

    # MACg
    #export PATH=$PATH:/Users/alonshaiber/PycharmProjects/MACg/bin:/Users/alonshaiber/PycharmProjects/MACg/tests
    #export PYTHONPATH=$PYTHONPATH:/Users/alonshaiber/PycharmProjects/MACg/
    #export PATH=$PATH:/Users/alonshaiber/PycharmProjects

    # PRICE assembler
    export PATH=$PATH:/Users/alonshaiber/MyLibraries/PriceSource140408

    # gcc (installed by brew)
    # in order for gcc to be invoked (and not clang), I did:
    # $ cd /usr/local/bin
    # $ ln -s  gcc-6  gcc
    # $ ln -s g++-6 g++
    # after using these, I then deleted them (could always be put back):
    # $ cd /usr/local/bin
    # $ rm gcc g++

    #prodigal

    export PATH=$PATH:/Users/alonshaiber/MyLibraries/Prodigal-2.6.2

    alias anvi-activate="source ~/virtual-envs/anvio-master/bin/activate; export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES"

    # set up key for ascp access to HMP
    export ASPERA_SCP_PASS=hmpsucks

    # set alias for inkscape
    alias inkscape=/Applications/Inkscape.app/Contents/Resources/bin/inkscape

    # added by Miniconda3 installer
    # export PATH="/Users/alonshaiber/miniconda3/bin:$PATH"  # commented out by conda initialize  # commented out by conda initialize

    # Add NCBI_DB and gimmetaxa to the path (https://github.com/kblin/ncbi-genome-download#contributed-scripts-gimme_taxapy)
    export PATH="/Users/alonshaiber/MyLibraries/NCBI_TAXONOMY_DB:$PATH"

    # Adding some random scripts to my path
    export PATH="/Users/alonshaiber/MyLibraries/Mybin:$PATH"

    # Adding minimap2 to my path
    export PATH="~/github/minimap2:$PATH"

    ## Adding sratoolkit
    export PATH="/Users/alonshaiber/MyLibraries/sratoolkit.2.9.6-1-mac64/bin:$PATH"

    ## adding oral toolkit to the path
    export PATH="/Users/alonshaiber/github/2018_Shaiber_Delmont_et_al_Saccharibacteria/scripts/OralMGXUtils:$PATH"
    export PYTHONPATH=$PYTHONPATH:/Users/alonshaiber/github/2018_Shaiber_Delmont_et_al_Saccharibacteria/scripts/OralMGXUtils

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/alonshaiber/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/alonshaiber/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/alonshaiber/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/alonshaiber/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
    fi

if [[ "$mski_server" =~ "$(uname -n)" ]] || [[ "$mski_server2" =~ "$(uname -n)" ]]; then

    echo "Hi $USER, setting up your configuration right away!"

    # aliases and the likes that I define in my .bash_utils
    mskiserversetup

    # From here below this is stuff I adopted as-is from Marcin
    # -------------------------------------------------------------------------

    ## Create backup of dotfiles
    cp ~/.bashrc ~/.old.config/
    cp ~/.bash_profile ~/.old.config/
    cp ~/.inputrc ~/.old.config/
    cp ~/.screenrc ~/.old.config/
    cp ~/.spacemacs ~/.old.config/

    # # Get the aliases and functions
    # if [ -f ~/.bashrc ]; then
    # 	. ~/.bashrc
    # fi

    # User specific environment and startup programs
    stty -ixon

    export CPLEX_DIR=/gpfs/commons/home/mimielinski/lab/Software/CPLEX/CPLEX_Studio/

    # Source global definitions
    if [ -f /etc/bashrc ]; then
          bash /etc/bashrc
    fi

    export LOCKPRG='/bin/true' 
    export LD_LIBRARY_PATH=~/modules/Snowman:$LD_LIBRARY_PATH:~/modules/Snowman/lib
    export PATH=~/software/emacs-25.2/bin/:~/lab/Software/mosh/bin/:~/lab/Software/Juicer/:~/lab/.local/bin/:~/git/dapars/:~/lab/git/MACS/bin/:~/scripts/:~/modules/Snowman/:~/modules/STAR:/nethome/mimielinski/Software/sshpass-1.05:~/Software/sratoolkit.2.5.7-centos_linux64/bin:~/Software/HMMCopy/HMMcopy/bin/:~/Software/UCSC/:$PATH:$HOME/bin:$HOME/dev/scripts/:$HOME/Scripts/bash:~/lab/Software/CPLEX/CPLEX_Studio/cplex/bin/x86-64_linux/
    export PATH=~/myscripts:$PATH

    export SKI_DB_ROOT="~/DB/"
    export SKI_SOFTWARE_ROOT="~/Software/"
    export GIT_HOME="~/git"
    export DEFAULT_BSGENOME="/gpfs/commons/groups/imielinski_lab/DB/UCSC/hg19.chrom.sizes"
    #export DISPLAY=:0



    module load samtools
    module load meme/4.11.2
    module load sratoolkit/2.9.6
    module load gcc/8.2.0
    module load bcftools
    module load java/1.8
    module load git-lfs
    #module add gcc/4.9.2
    #module load bwa/0.7.12
    #module load perl/5.10.0
    #module load samtools/1.1
    #module load python/2.7.8
    #module load python/2.7.11
    #module load python/2.7.10


    export PYTHONPATH="/gpfs/commons/groups/imielinski_lab/lib/python-3.5.1:$PYTHONPATH"

    if [ $( grep 'CentOS Linux release 7' /etc/redhat-release | wc -l ) -eq "1" ]
    then
        #myRLibs='/gpfs/commons/groups/imielinski_lab/lib/R-3.6.1'
        myRLibs='/gpfs/commons/groups/imielinski_lab/lib/R-4.0.2'
        echo "Centos 7 detected: R_LIBS=$myRLibs" 1>&2
        module load bedtools ## centos 7 version
        module unload python
        module load python/3.7.1
        
        module unload R
        #module load R/3.6.1
        module load R/4.0.2
        export R_LIBS=$myRLibs
    else
        export PATH="/gpfs/commons/groups/imielinski_lab/Software/miniconda3/bin:$PATH"
    #    export PATH="/gpfs/commons/home/mimielinski/Software/miniconda3/bin:$PATH"
        export R_LIBS='~/lab/lib/R-miniconda3'
        echo 'Centos 6 detected:  R_LIBS=~/lab/lib/R-3.3.0-Centos6/' 1>&2         
        export PYTHONPATH=/gpfs/commons/groups/imielinski_lab/lib/python-3.5.1-CentOS6/site-packages
    fi

    # exuberant ctags (needed for vim)
    export PATH=/gpfs/commons/home/ashaiber/mybin/ctags-5.8/:$PATH

    alias jupyter_run="xvfb-run jupyter notebook --notebook-dir=~/"


    # Finished adapting your PATH environment variable for use with MacPorts.

    PS1='\s:\h:\w \! \$ '

    alias picard="java -jar ~/modules/BWAMem/picard.jar"
    alias lsh="ls -lh"
    alias lss="ls -lSrh"
    alias lst="ls -lhrt"
    alias lsd="ls -ld */"
    alias duh="du -h --max-depth 1" 
    alias michor="ssh marcin@sphinx.dfci.harvard.edu"
    alias eris="ssh -Y mbi1@rgs03.research.partners.org"
    alias cga3="ssh -Y marcin@cga3.broadinstitute.org"
    alias cga2="ssh -Y marcin@cga2.broadinstitute.org"
    alias copper="ssh -Y marcin@copper.broadinstitute.org"
    alias gold="ssh -Y marcin@gold.broadinstitute.org"
    alias kras="ssh -Y marcin@cga-kras.broadinstitute.org"
    alias tp53="ssh -Y marcin@cga-tp53.broadinstitute.org"
    alias rb1="ssh -Y marcin@cga-rb1.broadinstitute.org"
    alias cdk="ssh -Y marcin@cga-cdkn2a.broadinstitute.org"
    alias wcmc="ssh -Y mai9037@aristotle.med.cornell.edu"
    alias penn="ssh pennstation"
    alias harlem="ssh harlem"
    alias sr="screen -r -d"
    alias sd="screen -d -r"
    alias dcc="sftp imielinskim@dccsftp.nci.nih.gov"
    alias rf="readlink -f"
    alias TIME="~/Software/time/time -v"
    alias igv='java -Xmx4g -jar ~/software/IGV_2.3.25/igv.jar'
    alias vncspawn="vncserver -geometry 2560x1440"
    alias vnckill="vncserver -kill"
    alias cnode="qrsh -q commons.q -l h_vmem=80G"
    alias pnode="qrsh -q prod.q -l h_vmem=80G"
    alias gdc='module unload python/3.7.1; module load gdc; gdc-client'
    alias lynx="/gpfs/commons/home/mimielinski/Software/lynx2.8.9dev.14/lynx ./lynx -cfg /gpfs/commons/home/mimielinski/Software/lynx2.8.9dev.14/lynx.cfg -lss /gpfs/commons/home/mimielinski/Software/lynx2.8.9dev.14//lynx.lss"
    #alias ls="TERM=ansi ls --color=always"

    # -------------------------------------------------------------------------
    # Alon's stuff
    # -------------------------------------------------------------------------
    echo "Loading vim"
    module load vim/8.2.0

    # add path to latest binutils
    # I needed this in order to install the package gert in R
    # this is commented out, but kept here for documentation purposes
    # export PATH=/gpfs/commons/home/ashaiber/mybin/binutils/bin:$PATH
# -------------------------------------------------------------------------
# >>>>> Done with mski_server configurations <<<<< 
fi
