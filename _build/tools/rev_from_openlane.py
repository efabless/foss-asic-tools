#!python3
import argparse
import tools_lib.dockerfile_manipulator as df_man
import tools_lib.yaml_manipulator as yaml_man

OPENLANE_TOOL_METADATA_URL_FSTR = "https://raw.githubusercontent.com/The-OpenROAD-Project/OpenLane/{0}/dependencies/tool_metadata.yml"

if __name__ == "__main__":
    prs = argparse.ArgumentParser(description="Update the tool commits/revisions from the openlane-Repository")
    prs.add_argument("--url", action="store", type=str, required=False, default=OPENLANE_TOOL_METADATA_URL_FSTR, help="This is the URL from which the metadata YAML file is loaded. Can include {0}, where the commit/tag of the repository is added.")
    prs.add_argument("--dry-run", action="store_true", help="Disable writing the Dockerfile, just print the results.")
    prs.add_argument("--dockerfile-path", action="store", type=str, default="./Dockerfile", help="Change the location of the Dockerfile involved.")
    prs.add_argument("--metadata-path", action="store", type=str, default="tool_metadata.yml", help="Change the location of the tool_metadata.yml output file. Write disabled if the filename is empty.")
    prs.add_argument("commit", metavar="commit", type=str, help="The commit (can be tag or hash) to load the metadata YAML from.")

    args = prs.parse_args()

    print(f"Loading tool metadata from: \"{args.url.format(args.commit)}\"")
    raw_meta = yaml_man.metadata_load(tag=args.commit, url_fstr=args.url)
    if raw_meta is not None:
        data = yaml_man.metadata_parse(raw_meta)
        print(f"Loading Dockerfile from: \"{args.dockerfile_path}\"")
        df_contents = df_man.read_dockerfile(path=args.dockerfile_path)
        if df_contents is not None:
            tools = df_man.get_existing_tools(df_contents)
            for tool in tools:
                new_rev =  yaml_man.get_revision(data, tool)
                if new_rev is not None:
                    print(f"Found for {tool}: {new_rev}")
                    if not df_man.update_revision(df_contents, tool, new_rev):
                        print( "###########################################################")
                        print(f"ERROR: updating the revision for {tool} failed!")
                        print( "###########################################################")
            print(f"Updating openlane to revision {args.commit}.")
            if not df_man.update_revision(df_contents, "openlane", args.commit):
                print("###########################################################")
                print("ERROR: updating the revision for openlane failed!")
                print("###########################################################")
            if not args.dry_run:
                print(f"Writing Dockerfile to {args.dockerfile_path}")
                df_man.write_dockerfile(df_contents, path=args.dockerfile_path)
                if len(args.metadata_path)>0:
                    print(f"Writing metadata yaml to {args.metadata_path}")
                    yaml_man.metadata_write(raw_meta, path=args.metadata_path)