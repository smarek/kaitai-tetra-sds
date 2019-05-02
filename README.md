## TETRA SDS Kaitai Struct

Kaitai Struct definition to parse UL/DL TETRA SDS messages

### Howto

  - pip3 install -r requirements.txt
  - optionally edit *.ksy definitions
  - kaitai-struct-compiler -t python *.ksy
  - ./start.py

### Convert hex data into binary form

  - xxd -r -e -p sample2.text sample2.bin
