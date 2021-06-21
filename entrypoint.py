import os
import argparse


def main():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest='transformation', help='select transformation pipeline')
    uml2owl_parser = subparsers.add_parser('shapechange', help='transform a uml model to an owl ontology via ShapeChange')
    uml2owl_parser.add_argument('config', help='specify the shapechange configuration file')
    uml2owl_parser.add_argument('--input', help='specify the uml file to transform')
    xml2rdf_parser = subparsers.add_parser('xml2rdf', help='transform an xml file into a rdf graph')
    xml2rdf_parser.add_argument('input_file', help='specify the input CityGML datafile')
    xml2rdf_parser.add_argument('input_model', help='specify the ontology input path; for multiple ontologies, input paths are separated by a ","')
    xml2rdf_parser.add_argument('mapping_file', help='specify the namespace mapping file.')
    xml2rdf_parser.add_argument('--format', default='ttl', choices=['ttl', 'rdf'], help='specify the output data format (ttl by default)')
    xml2rdf_parser.add_argument('--log', default='./inout/output.log', help='specify the logging file (output.log by default)')
    xsd2owl_parser = subparsers.add_parser('xsd2owl', help='transform an xsd file into an owl ontology')
    xsd2owl_parser.add_argument('input', help='specify the input xsd file to transform')
    xsd2owl_parser.add_argument('output', default='./output', help='specify the output directory')
    args = parser.parse_args()

    command = ''
    if args.transformation == 'shapechange':
        command = (f"java -jar lib/ShapeChange-2.10.0.jar -Dfile.encoding=UTF-8 " +
            f"-c /inout/{args.config} -x '$input$' '/inout/{args.input}' -x '$output$' '/inout/'")
    elif args.transformation == 'xml2rdf':
        command = (f'python XML-to-RDF/OWL-based-transformations/CityGML2RDF.py ' +
            f'{args.input_file} {args.input_model} {args.mapping_file} --log {args.log} ' +
            f'--format {args.format} --output /UD-Graph/Transformations/inout')
    elif args.transformation == 'xsd2owl':
        command = f'python XSD-to-OWL/run.py {args.input} {args.output}'

    print(command)
    os.system(command)


if __name__ == "__main__":
    main()
