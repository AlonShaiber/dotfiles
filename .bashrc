# find by typing `uname -n`
nygcbook="ASHAIBER01"
macbook="Alons-MBP.stny.rr.com"
mski_server="mskilab01.c.nygenome.org"

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

# autocorrects small mistakes
shopt -s cdspell

# ls coloring
export CLICOLOR=1
export LSCOLORS=gxhxCxDxBxegedabagaced


# -----------------------------------------------------------------------------
# }}} MY MACBOOK {{{
# -----------------------------------------------------------------------------

if [[ "$macbook" =~ "$(uname -n)" ]]; then

    macsetup
    mskisetup
    merenlabsetup

    MY_R_LIBS="/Library/Frameworks/R.framework/Versions/3.6/Resources/library"
    if [ -n $R_LIBS ]; then
       export R_LIBS=$MY_R_LIBS:$R_LIBS
    else
       export R_LIBS=$MY_R_LIBS
    fi
fi

if [[ "$mski_server" =~ "$(uname -n)" ]]; then

    # -------------------------------------------------------------------------
    # Alon's stuff
    # -------------------------------------------------------------------------
    module load vim/8.2.0

    # -------------------------------------------------------------------------
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
    module load sratoolkit/2.8.1
    module load gcc/6.2.0
    #module load java/1.8
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
        foo='~/lab/lib/R-3.5.1/:/nfs/sw/R/R-3.5.1/lib64/R/library/'
        echo "Centos 7 detected: R_LIBS=$foo" 1>&2
        module load bedtools ## centos 7 version
        module remove python/2.7.8  # default load, python/3.5.1
        module load python/3.5.1    # default load, python/3.5.1
        
    #    export R_LIBS="/data/research/mski_lab/Software/R7"
        module unload R
        module load R/3.5.1
        export R_LIBS=$foo
    else
        export PATH="/gpfs/commons/groups/imielinski_lab/Software/miniconda3/bin:$PATH"
    #    export PATH="/gpfs/commons/home/mimielinski/Software/miniconda3/bin:$PATH"
        export R_LIBS='~/lab/lib/R-miniconda3'
        echo 'Centos 6 detected:  R_LIBS=~/lab/lib/R-3.3.0-Centos6/' 1>&2         
        export PYTHONPATH=/gpfs/commons/groups/imielinski_lab/lib/python-3.5.1-CentOS6/site-packages
    fi


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
    alias gdc="module unload  python/3.5.1; module load python/2.7.11; ~/software/GDC/gdc-client download -m"
    alias lynx="/gpfs/commons/home/mimielinski/Software/lynx2.8.9dev.14/lynx ./lynx -cfg /gpfs/commons/home/mimielinski/Software/lynx2.8.9dev.14/lynx.cfg -lss /gpfs/commons/home/mimielinski/Software/lynx2.8.9dev.14//lynx.lss"
    #alias ls="TERM=ansi ls --color=always"
# >>>>> Done with mski_server configurations <<<<< 
fi
