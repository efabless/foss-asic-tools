import os
import yaml
import multiprocessing
import subprocess

if __name__ == "__main__":
    corners_str = open("./corners.yml").read()
    corners_by_scl = yaml.safe_load(corners_str)

    def make_timing_on_scl(scl: str, *corners):
        print(f"Starting on {scl}: {corners}...", flush=True)
        subprocess.check_output(
            [
                "python3",
                "-m",
                "skywater_pdk.liberty",
                f"libraries/{scl}/latest",
                *corners,
            ]
        )
        print(f"{scl} done.", flush=True)

    pool = multiprocessing.Pool()
    for scl, corners in corners_by_scl.items():
        pool.apply_async(make_timing_on_scl, (scl, *corners))
    pool.close()
    pool.join()
