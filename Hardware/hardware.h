/*
    WAVE file header structure
    src - http://truelogic.org/wordpress/2015/09/04/parsing-a-wav-file-in-c/
*/
struct HEADER {
	unsigned char riff[4];						// "RIFF" 
	unsigned int overall_size;					// overall size of file in bytes
	unsigned char wave[4];						// "WAVE"
	unsigned char fmt_chunk_marker[4];			// "fmt" + trailing null char
	unsigned int length_of_fmt;					// length of the format data
	unsigned int format_type;					// format type. 1-PCM
	unsigned int channels;						// no.of channels
	unsigned int sample_rate;					// Sample Rate = Number of Samples per second
	unsigned int byterate;						// (Sample Rate * BitsPerSample * Channels) / 8
	unsigned int block_align;					// (BitsPerSample * Channels) / 8
	unsigned int bits_per_sample;				// bits per sample, 8- 8bits, 16- 16 bits etc
	unsigned char data_chunk_header [4];		// "DATA"
	unsigned int data_size;						// NumSamples * NumChannels * BitsPerSample/8 - Size of the data section.
};


/*
	Function declarations
*/


void readWaveFile(FILE *new_fp);
void readWaveFileDataSamples(FILE *new_fp);

void compression(long num_samples);
void decompression(FILE *new_fp, long num_samples, long size_of_each_sample);

void compressDataSamples(long num_samples);
void decompressDataSamples(long num_samples);

int codeword_compression(int sample);
unsigned short codeword_decompression(char codeword);

// void saveCompressedDataSamples();
void saveFile(FILE *new_fp, long num_samples, long size_of_each_sample);