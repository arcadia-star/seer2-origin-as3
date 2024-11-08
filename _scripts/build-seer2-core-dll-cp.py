import shutil
import subprocess

source_file = "../out/Seer2CoreDLL.swf"
destination_folder = "E:\sync\seer2\dll\Seer2CoreDLL.swf"

# 要执行的另一个 Python 脚本的路径
another_script_path = "build-seer2-core-dll.py"

try:
    # 使用 subprocess.run 执行另一个脚本
    result = subprocess.run(["python", another_script_path], capture_output=True, text=True, check=True)

    # 打印另一个脚本的输出
    print("Output of another script:")
    print(result.stdout)

    # 使用 shutil.copy2 进行文件拷贝，保留元数据（如修改时间）
    shutil.copy2(source_file, destination_folder)
    print(f"File copied successfully from {source_file} to {destination_folder}")

except FileNotFoundError:
    print(f"Error: {another_script_path} not found.")
except subprocess.CalledProcessError as e:
    print(f"Error while running the script: {e}")
except Exception as e:
    print(f"An error occurred: {e}")
