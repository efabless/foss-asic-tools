#!python3
import argparse
import tools_lib.dockerfile_manipulator as df_man
import tools_lib.yaml_manipulator as yaml_man


if __name__ == "__main__":
    prs = argparse.ArgumentParser(description="Update the tool commits/revisions from a local yaml file (e.g.: tool_metadata_add.yml)")
    prs.add_argument("--dry-run", action="store_true", help="Disable writing the Dockerfile, just print the results.")
    prs.add_argument("--dockerfile-path", action="store", type=str, default="Dockerfile", help="Change the location of the Dockerfile involved.")
    prs.add_argument("--metadata-path", action="store", type=str, default="tool_metadata_add.yml", help="Change the location of the tool_metadata_add.yml input file.")

    args = prs.parse_args()

    print(f"Loading tool metadata from: \"{args.metadata_path}\"")
    raw_meta = yaml_man.metadata_read(args.metadata_path)
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
        #print(df_contents)
            if not args.dry_run:
                print(f"Writing Dockerfile to {args.dockerfile_path}")
                df_man.write_dockerfile(df_contents, path=args.dockerfile_path)
    #print([x for x in data if x['name'] == 'drcu'][0])