import re
import subprocess
import os

prefix = config['prefix']
maxthreads = snakemake.utils.available_cpu_count()

logs = config['base_log_outdir']



rule run_fastp:
    input:
        r1 = config['raw_reads_path']+"/{sample}.R1.fastq.gz",
        r2 = config['raw_reads_path']+"/{sample}.R2.fastq.gz"
    output:
        r1_filt = config['outdir']+"/{prefix}/fastp/{sample}.R1.fastq.gz",
        r2_filt = config['outdir']+"/{prefix}/fastp/{sample}.R2.fastq.gz",
        json = config['outdir']+"/{prefix}/fastp/{sample}.fastp.json",
        html = config['outdir']+"/{prefix}/fastp/{sample}.fastp.html"
    log:
        config['base_log_outdir']+"/{prefix}/fastp/run/{sample}.log"
    threads:
        2
    conda:
        "../envs/fastp.yaml"
    shell:
        """
        fastp -i {input.r1} -I {input.r2} -o {output.r1_filt} -O {output.r2_filt} -j {output.json} -h {output.html} 2>&1 {log}
        """
