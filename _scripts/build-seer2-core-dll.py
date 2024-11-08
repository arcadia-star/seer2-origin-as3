import zlib
import zipfile

zip_file_path = "../out/Seer2CoreDLL.swc"  # 替换为你的 ZIP 文件路径
output_file_path = "../out/Seer2CoreDLL.swf"  # 输出文件路径

try:
    with zipfile.ZipFile(zip_file_path, 'r') as zip_file:
        # 获取 ZIP 文件中的所有文件列表
        file_list = zip_file.namelist()

        # 检查是否存在 library.swf 文件
        if 'library.swf' in file_list:
            # 提取 library.swf 文件内容
            with zip_file.open('library.swf') as library_swf_file:
                swf_content = library_swf_file.read()

                # 对整个数据流进行 zlib 压缩
                compressed_data = b'\x00' * 7 + zlib.compress(swf_content)

                # 将结果输出到文件 a.bin 中
                with open(output_file_path, 'wb') as output_file:
                    output_file.write(compressed_data)

                print(f"Data compressed and saved to {output_file_path}")
        else:
            print("library.swf not found in the ZIP file.")

except FileNotFoundError:
    print(f"ZIP file not found: {zip_file_path}")
except zipfile.BadZipFile:
    print(f"The provided file is not a valid ZIP file.")
except Exception as e:
    print(f"An error occurred: {e}")
