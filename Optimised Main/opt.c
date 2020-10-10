/*
    Project - Audio Compression
    SENG 440 
    Audio Compression Software optimised C file
    By - 
        Divya Chawla V00862263
        Purvika Dutt V00849852
    Submitted on - August 12th, 2020
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "opt.h"
#include <time.h>

FILE *fp;
struct HEADER header;

unsigned char buffer4[4];
unsigned char buffer2[2];

time_t start, stop;


int *sample_data;
__uint8_t *compressed_sample_data;


/*
    Main function
*/
int main (int argc, char **argv) {
    if (argc < 2) {
        printf("Please input a valid .wav file \n");
        exit(1);
    }
    //debugging - correct file is used
    printf("\n Input Wave Filename: %s\n", argv[1]);

    //open .wav file in binary mode
    fp = fopen(argv[1], "rb");  
    if (fp == NULL) {
        printf("Error opening .wav file: %s", argv[1]);
        exit(1);
    }

     // create a new file to write to
    printf("Creating new WAV file ...\n\n");
    char new_file_str[50];
    strcpy(new_file_str, "new_");
    strcat(new_file_str, argv[1]);
    FILE *new_fp;
    new_fp = fopen(new_file_str, "wb");


    //parse .wav file
    readWaveFile(new_fp);
    //parse data sample
    readWaveFileDataSamples(new_fp);

    return 0;
}

/*
    Parse the .wav file and then display the header on terminal
    src - http://truelogic.org/wordpress/2015/09/04/parsing-a-wav-file-in-c/
*/
void readWaveFile(FILE *new_fp){
// read header parts
    int read = 0;

    printf("Reading Wave File Headers.... \n");

    // 1 - 4: RIFF string - Marks the file as a riff file. Characters are each 1 byte long.
    read = fread(header.riff, sizeof(header.riff), 1, fp);
    fwrite(header.riff, sizeof(header.riff), 1, new_fp);
    printf("(1-4): %s \n", header.riff);

    // 5 - 8: Size of the overall file – 8 bytes, in bytes (32-bit integer)
    read = fread(buffer4, sizeof(buffer4), 1, fp);
    fwrite(&buffer4[0], sizeof(buffer4[0]), 1, new_fp);
    fwrite(&buffer4[1], sizeof(buffer4[1]), 1, new_fp);
    fwrite(&buffer4[2], sizeof(buffer4[2]), 1, new_fp);
    fwrite(&buffer4[3], sizeof(buffer4[3]), 1, new_fp);
    // convert little endian to big endian 4 byte int
    header.overall_size  = buffer4[0] | (buffer4[1]<<8) | (buffer4[2]<<16) | (buffer4[3]<<24);
    printf("(5-8) Overall size: bytes:%u, Kb:%u \n", header.overall_size, header.overall_size/1024);

    // 9 - 12: WAV string - File Type Header. For our purposes, it always equals “WAVE”
    read = fread(header.wave, sizeof(header.wave), 1, fp);
    fwrite(header.wave, sizeof(header.wave), 1, new_fp);
    printf("(9-12) Wave marker: %s\n", header.wave);

    // 13 - 16: fmt string - Format chunk marker. Includes trailing null
    read = fread(header.fmt_chunk_marker, sizeof(header.fmt_chunk_marker), 1, fp);
    fwrite(header.fmt_chunk_marker, sizeof(header.fmt_chunk_marker), 1, new_fp);
    printf("(13-16) Fmt marker: %s\n", header.fmt_chunk_marker);

    // 17 - 20: length of format data
    read = fread(buffer4, sizeof(buffer4), 1, fp);
    fwrite(&buffer4[0], sizeof(buffer4[0]), 1, new_fp);
    fwrite(&buffer4[1], sizeof(buffer4[1]), 1, new_fp);
    fwrite(&buffer4[2], sizeof(buffer4[2]), 1, new_fp);
    fwrite(&buffer4[3], sizeof(buffer4[3]), 1, new_fp);
    header.length_of_fmt = buffer4[0] | (buffer4[1] << 8) |	(buffer4[2] << 16) | (buffer4[3] << 24);
    printf("(17-20) Length of Fmt header: %u \n", header.length_of_fmt);

    // 21 - 22: Type of format (1 is PCM) – 2 byte integer
    read = fread(buffer2, sizeof(buffer2), 1, fp);
    fwrite(&buffer2, sizeof(buffer2), 1, new_fp);
    header.format_type = buffer2[0] | (buffer2[1] << 8);
    printf("(21-22) Format type: %u \n", header.format_type);

    // 23 - 24: Number of Channels – 2 byte integer
    read = fread(buffer2, sizeof(buffer2), 1, fp);
    fwrite(&buffer2, sizeof(buffer2), 1, new_fp);
    header.channels = buffer2[0] | (buffer2[1] << 8);
    printf("(23-24) Channels: %u \n", header.channels);

    // 25 - 28: Sample Rate – 32 byte integer; Sample Rate = Number of Samples per second
    read = fread(buffer4, sizeof(buffer4), 1, fp);
    fwrite(&buffer4[0], sizeof(buffer4[0]), 1, new_fp);
    fwrite(&buffer4[1], sizeof(buffer4[1]), 1, new_fp);
    fwrite(&buffer4[2], sizeof(buffer4[2]), 1, new_fp);
    fwrite(&buffer4[3], sizeof(buffer4[3]), 1, new_fp);
    header.sample_rate = buffer4[0] | (buffer4[1] << 8) | (buffer4[2] << 16) | (buffer4[3] << 24);
    printf("(25-28) Sample rate: %u\n", header.sample_rate);

    // 29 - 32: Byte rate - (Sample Rate * BitsPerSample * Channels) / 8
    read = fread(buffer4, sizeof(buffer4), 1, fp);
    fwrite(&buffer4[0], sizeof(buffer4[0]), 1, new_fp);
    fwrite(&buffer4[1], sizeof(buffer4[1]), 1, new_fp);
    fwrite(&buffer4[2], sizeof(buffer4[2]), 1, new_fp);
    fwrite(&buffer4[3], sizeof(buffer4[3]), 1, new_fp);
    header.byterate  = buffer4[0] | (buffer4[1] << 8) |	(buffer4[2] << 16) | (buffer4[3] << 24);
    printf("(29-32) Byte Rate: %u , Bit Rate:%u\n", header.byterate, header.byterate*8);

    // 33 - 34: Block Alignment - (BitsPerSample * Channels) / 8
    read = fread(buffer2, sizeof(buffer2), 1, fp);
    fwrite(&buffer2, sizeof(buffer2), 1, new_fp);
    header.block_align = buffer2[0] | (buffer2[1] << 8);
    printf("(33-34) Block Alignment: %u \n", header.block_align);

    // 35 - 36: Bits per sample
    read = fread(buffer2, sizeof(buffer2), 1, fp);
    fwrite(&buffer2, sizeof(buffer2), 1, new_fp);
    header.bits_per_sample = buffer2[0] | (buffer2[1] << 8);
    printf("(35-36) Bits per sample: %u \n", header.bits_per_sample);

    // 37 - 40: data string - “data” chunk header. Marks the beginning of the data section
    read = fread(header.data_chunk_header, sizeof(header.data_chunk_header), 1, fp);
    fwrite(&header.data_chunk_header, sizeof(header.data_chunk_header), 1, new_fp);
    printf("(37-40) Data Marker: %s \n", header.data_chunk_header);

    // 41 - 44: data size
    read = fread(buffer4, sizeof(buffer4), 1, fp);
    fwrite(&buffer4[0], sizeof(buffer4[0]), 1, new_fp);
    fwrite(&buffer4[1], sizeof(buffer4[1]), 1, new_fp);
    fwrite(&buffer4[2], sizeof(buffer4[2]), 1, new_fp);
    fwrite(&buffer4[3], sizeof(buffer4[3]), 1, new_fp);
    header.data_size = buffer4[0] |	(buffer4[1] << 8) |	(buffer4[2] << 16) | (buffer4[3] << 24 );
    printf("(41-44) Size of data chunk: %u \n", header.data_size);

    printf("COMPLETED Reading Wave File Headers \n\n");
}

/*
    Read .wav file data samples 
*/
void readWaveFileDataSamples(FILE *new_fp) {
    //only allow PCM file data 
    if (header.format_type == 1){ 
        printf("Reading PCM data...\n");

        int i;
        long num_samples;
        long size_of_each_sample;
        
        num_samples = (8 * header.data_size) / (header.channels * header.bits_per_sample);
        printf("Number of samples:%lu \n", num_samples);

        size_of_each_sample = (header.channels * header.bits_per_sample) / 8;
        printf("Size of each sample:%ld bytes\n", size_of_each_sample);
        
        sample_data = calloc(num_samples, size_of_each_sample);
        if (sample_data == NULL) {
            printf("Could not allocate enough memory to read data samples\n");
            exit(1);
        }

        for (i = 0; i < num_samples; i++) {
        #pragma HLS unroll factor=10
            fread(buffer2, size_of_each_sample, 1, fp);
            sample_data[i] = (buffer2[0]) | (buffer2[1] << 8);
        }

        printf("COMPLETED Reading PCM data \n\n");

        compression(num_samples);
        decompression(new_fp, num_samples, size_of_each_sample);
    }
    //if not PCM 
    else
    {
        printf("Cannot proceed! Only PCM data allowed!\n");
        exit(1);      
    }
}

/*
    Compression
*/
void compression(long num_samples){
    start = clock();
    
    printf("Compressing Data Samples.... \n");
    compressed_sample_data = calloc(num_samples, sizeof(char));
    if (compressed_sample_data == NULL) {
        printf("Could not allocate enough memory to store compressed data samples\n");
        return;
    }
    int i;
    for (i = 0; i < num_samples; i++) {
    #pragma HLS unroll factor=10
        int sample = (sample_data[i] >> 2);
        short sign = sample >=0;
        unsigned short magnitude = (sample < 0 ? -sample : sample) + 33;
        //optimised
        compressed_sample_data[i] = ~(codeword_compression(magnitude, sign));
    }
    printf("COMPLETED Compressing data samples \n\n");

    stop = clock();
    //optimised
    printf("Audio Compression using Mu Law: %f seconds \n\n", (double) (stop - start) / CLOCKS_PER_SEC);

}

/*
    Decompression
*/
void decompression(FILE *new_fp, long num_samples, long size_of_each_sample){
    start = clock();
    
    printf("Decompressing Data Samples....\n");
    int codeword;
    int i;
    for (i = 0; i < num_samples; i++) {
    #pragma HLS unroll factor=10
        //Before transmission the μ-law codeword is inverted
        codeword = ~(compressed_sample_data[i]);
        short sign = (codeword & 0x80) >> 7;
        unsigned short magnitude = (codeword_decompression(codeword) - 33);
        short sample = (short) (sign ? magnitude : -magnitude);
        sample_data[i] = sample << 2;
    }
    printf("COMPLETED decompressing data sample \n\n");

    stop = clock();
    saveFile(new_fp, num_samples, size_of_each_sample);
    
    //optimised
    printf("Audio Decompression using Mu Law: %f seconds\n\n", (double) (stop - start) / CLOCKS_PER_SEC);

}


// int codeword_compression(unsigned short sample_magnitude, short sign) {
//     int chord, step; 

//     if( sample_magnitude & (1 << 12)) {
//         chord = 0x7;
//         step = (sample_magnitude >> 8) & 0xF; 
//     }
//     else if( sample_magnitude & (1 << 11)) {
//         chord = 0x6;
//         step = (sample_magnitude >> 7) & 0xF; 
//     }
//     else if( sample_magnitude & (1 << 10)) {
//         chord = 0x5;
//         step = (sample_magnitude >> 6) & 0xF; 
//     }
//     else if( sample_magnitude & (1 << 9)) {
//         chord = 0x4;
//         step = (sample_magnitude >> 5) & 0xF; 
//     }
//     else if( sample_magnitude & (1 << 8)) {
//         chord = 0x3;
//         step = (sample_magnitude >> 4) & 0xF; 
//     }
//     else if( sample_magnitude & (1 << 7)) {
//         chord = 0x2;
//         step = (sample_magnitude >> 3) & 0xF; 
//     }
//     else if( sample_magnitude & (1 << 6)) {
//         chord = 0x1;
//         step = (sample_magnitude >> 2) & 0xF; 
//     }
//     else if( sample_magnitude & (1 << 5)) {
//         chord = 0x0;
//         step = (sample_magnitude >> 1) & 0xF; 
//     } 
//     else {
//         chord = 0x0;
//         step = sample_magnitude;
//     }
//     //optimised
//     return ( (int)((sign << 7) | (chord << 4) | step));
// }


int codeword_compression(unsigned short sample_magnitude, short sign) {
    int chord, step; 

    if( sample_magnitude & (1 << 5)) {
        chord = 0x0;
        step = (sample_magnitude >> 1) & 0xF; 
    }
    else if( sample_magnitude & (1 << 6)) {
        chord = 0x1;
        step = (sample_magnitude >> 2) & 0xF; 
    }
    else if( sample_magnitude & (1 << 7)) {
        chord = 0x2;
        step = (sample_magnitude >> 3) & 0xF; 
    }
    else if( sample_magnitude & (1 << 8)) {
        chord = 0x3;
        step = (sample_magnitude >> 4) & 0xF; 
    }
    else if( sample_magnitude & (1 << 9)) {
        chord = 0x4;
        step = (sample_magnitude >> 5) & 0xF; 
    }
    else if( sample_magnitude & (1 << 10)) {
        chord = 0x5;
        step = (sample_magnitude >> 6) & 0xF; 
    }
    else if( sample_magnitude & (1 << 11)) {
        chord = 0x6;
        step = (sample_magnitude >> 7) & 0xF; 
    }
    else {
        chord = 0x7;
        step = (sample_magnitude >> 8) & 0xF; 
    } 
    //optimised
    return ( (int)((sign << 7) | (chord << 4) | step));
}

unsigned short codeword_decompression(char codeword) {
    int chord = (codeword & 0x70) >> 4;
    int step = codeword & 0x0F;
    int msb = 1, lsb = 1;
    int magnitude;
    
    switch(chord) {
        case 0x0: 
            magnitude = lsb | (step << 1) | (msb << 5);
            break;
        case 0x1:
            magnitude = (lsb << 1) | (step << 2) | (msb << 6);
            break;
        case 0x2:
            magnitude = (lsb << 2) | (step << 3) | (msb << 7);
            break;
        case 0x3:
            magnitude = (lsb << 3) | (step << 4) | (msb << 8);
            break;
        case 0x4:
            magnitude = (lsb << 4) | (step << 5) | (msb << 9);
            break;
        case 0x5:
            magnitude = (lsb << 5) | (step << 6) | (msb << 10);
            break;
        case 0x6:
            magnitude = (lsb << 6) | (step << 7) | (msb << 11);
            break;
        case 0x7:
            magnitude = (lsb << 7) | (step << 8) | (msb << 12);
            break;
    }
    return (unsigned short) magnitude;
}


/*
    Save decompressed .wav file
*/
void saveFile(FILE *new_fp, long num_samples, long size_of_each_sample) {
    // data
    int i ;
    for (i = 0; i < num_samples; i++) {
    #pragma HLS unroll factor=10
        buffer2[0] =  sample_data[i] & 0x000000FF;
        buffer2[1] = (sample_data[i] & 0x0000FF00) >> 8;
        fwrite(buffer2, size_of_each_sample, 1, new_fp);
    }

    fclose(new_fp);
    printf("COMPLETED saving mu law file \n\n");
}