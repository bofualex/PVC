# ------------------------------------------------------------ Imports ----------------------------------------------------------- #

# System
from typing import List
import os, shutil
from datetime import datetime

# Local
from .constants import TAB_SIZE

# -------------------------------------------------------------------------------------------------------------------------------- #



# ------------------------------------------------------------- Vars ------------------------------------------------------------- #

TAB = TAB_SIZE * ' '

PROJECT_ROOT_PATH = os.path.dirname(os.path.dirname(os.path.dirname(__file__)))
PROJECT_NAME      = PROJECT_ROOT_PATH.rstrip(os.sep).split(os.sep)[-1]
PROJECT_CODE_PATH = os.path.join(PROJECT_ROOT_PATH, PROJECT_NAME)

GENERATED_FILE_FOLDER_PATH = os.path.join(PROJECT_CODE_PATH, 'Generated')


# ------------------------------------------------------------ Methods ----------------------------------------------------------- #

def cleanup() -> None:
    try:
        shutil.rmtree(GENERATED_FILE_FOLDER_PATH)
    except:
        pass

def rstrip(s: str, to_strip: str) -> str:
    return s[0:len(s)-len(to_strip)] if s.lower().endswith(to_strip.lower()) else s
def lstrip(s: str, to_strip: str) -> str:
    return s[len(to_strip)::] if s.lower().startswith(to_strip.lower()) else s

def to_name(s: str) -> str:
    return ''.join([v.title() for v in s.replace(' ', '_').split('_')]) if ' ' in s or '_' in s else s

def lowerCamelCase(s: str) -> str:
    return s[0].lower() + s[1::]
def upperCamelCase(s: str) -> str:
    return s[0].upper() + s[1::]

def generated_swift_file_path(name: str) -> str:
    return os.path.join(GENERATED_FILE_FOLDER_PATH, '{}.swift'.format(rstrip(name, '.swift')))

def scandir(dirname: str) -> List[str]:
    return [os.path.abspath(f.path) for f in os.scandir(dirname) if f.is_dir()]
def scanfiles(dirname: str) -> List[str]:
    return [os.path.abspath(f.path) for f in os.scandir(dirname) if not f.is_dir()]

def create_swift_file(
    name: str,
    imports: List[str],
    code: str
) -> bool:
    path = generated_swift_file_path(name)

    s = '''//
// {}
// {}
//
// Autogenerated by the python script
//

'''.format(
    path.rstrip(os.sep).split(os.sep)[-1],
    PROJECT_NAME
)

    if imports:
        s += '\n'.join(
            [
                'import {}'.format(imp)
                for imp in imports
            ]
        ) + '\n\n\n'

    os.makedirs(os.path.dirname(path), exist_ok=True)

    with open(path, 'w') as f:
        f.write(s + code.strip() + '\n')

    return os.path.exists(path)


# -------------------------------------------------------------------------------------------------------------------------------- #