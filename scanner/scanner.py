import os
import argparse
import requests
import json
import logging
import socket


# Создание логгера
logger = logging.getLogger('utility_logger')
logger.setLevel(logging.INFO)
log_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'utility.log')
file_handler = logging.FileHandler(log_file)
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
file_handler.setFormatter(formatter)
logger.addHandler(file_handler)

# Функция для записи "New request" в лог-файл
def log_new_request(command):
    logger.info(f">>>>> New request - {command} <<<<<")


# Функция для выполнения сканирования сети с помощью ping
def do_ping_sweep(ip, num_of_host):
    try:
        ip_address = socket.gethostbyname(ip)
    except socket.gaierror:
        logger.warning(f"Invalid IP address or domain name: {ip}")
        return
    
    ip_parts = ip_address.split('.')
    network_ip = '.'.join(ip_parts[:3]) + '.'
    scanned_ip = network_ip + str(int(ip_parts[3]) + num_of_host)
    response = os.popen(f'ping -n 1 {scanned_ip}')
    res = response.readlines()
    result = f"[#] Result of scanning: {scanned_ip} [#]\n{res[2]}"
    logger.info(result)
    print(result, end='\n\n')


# Функция для отправки HTTP-запроса
def sent_http_request(target, method, headers=None, payload=None):
    headers_dict = dict()
    if headers:
        for header in headers:
            header_name, header_value = header.split(':', maxsplit=1)
            headers_dict[header_name.strip()] = header_value.strip()

    if method == "GET":
        response = requests.get(target, headers=headers_dict)
    elif method == "POST":
        response = requests.post(target, headers=headers_dict, data=payload)
    
    result = (
        f"[#] Response status code: {response.status_code}\n"
        f"[#] Response headers: {json.dumps(dict(response.headers), indent=4, sort_keys=True)}\n"
        f"[#] Response content:\n {response.text}"
    )
    logger.info(result)
    print(result)


# Обработка аргументов командной строки
parser = argparse.ArgumentParser(description='Network scanner')
parser.add_argument('task', choices=['scan', 'sendhttp'], help='Network scan or send HTTP request')
parser.add_argument('-i', '--ip', type=str, help='IP address')
parser.add_argument('-n', '--num_of_hosts', type=int, help='Number of hosts')
parser.add_argument('-t', '--target', type=str, help='URL')
parser.add_argument('-m', '--method', type=str, help='Method')
parser.add_argument('-hd', '--headers', type=str, nargs='*', help='Headers')
args = parser.parse_args()


# В зависимости от выбранной задачи выполнение сканирования или отправка HTTP-запроса
if args.task == 'scan':
    command = f"scan -i {args.ip} -n {args.num_of_hosts}"
    log_new_request(command)
    for host_num in range(args.num_of_hosts):
        do_ping_sweep(args.ip, host_num)
elif args.task == 'sendhttp':
    command = f"sendhttp -t {args.target} -m {args.method} -hd {' '.join(args.headers) if args.headers else ''}"
    log_new_request(command)
    sent_http_request(args.target, args.method, args.headers)
