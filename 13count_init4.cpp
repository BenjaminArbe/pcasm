/* file: 13count_init04.cpp */


extern "C" {

void initialize_count_bits();

unsigned char byte_bit_count[256];	

int
count (unsigned int data) {
	const unsigned char *byte = (unsigned char *)&data;

	initialize_count_bits();

	return byte_bit_count[byte[0]] + byte_bit_count[byte[1]] +
			byte_bit_count[byte[2]] + byte_bit_count[byte[3]];
}
}

