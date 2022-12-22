import os
import sys

def main():
    command = ''
    print(sys.argv)
    if sys.argv[1] == 'xml2rdf':
        command = f'python ./XML-to-RDF/XML2RDF.py {" ".join(sys.argv[2:])}'
    elif sys.argv[1] == 'xsd2owl':
        command = f'cd ./XSD-to-OWL && python run.py {" ".join(sys.argv[2:])}'

    print(command)
    os.system(command)

if __name__ == "__main__":
    main()