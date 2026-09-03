# Hashes a file, ignoring all whitespace and comments. Use for
# verifying that code was correctly typed.
# Implemented in python3 (already a build dependency) instead of relying on
# GNU cpp -fpreprocessed / md5sum, which aren't available on macOS (clang's
# cpp rejects -fpreprocessed, and there is no md5sum, only md5).
python3 -c '
import hashlib
import re
import sys

src = sys.stdin.read()
src = re.sub(r"/\*.*?\*/", "", src, flags=re.S)
src = re.sub(r"//.*", "", src)
src = re.sub(r"\s+", "", src)
print(hashlib.md5(src.encode("utf-8")).hexdigest()[:6])
'
