import os

def get_dma_words_64b(num_words, word_bytes, dma):
    # Get n 64-bit words from DMA
    words = os.read(dma, word_bytes*(num_words))
    # Divide return characters into words
    chunks, chunk_size = len(words), len(words)//(num_words)
    # Slice words
    words = [words[i:i+chunk_size] for i in range(0, chunks, chunk_size) ]
    # Convert to uint64
    words_uint = []
    for word in words:
        word_uint = int.from_bytes(word, byteorder='big', signed=False)
        words_uint.append(word_uint)
    return words_uint