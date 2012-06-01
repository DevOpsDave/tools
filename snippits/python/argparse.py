if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("--config", metavar="FILE", default="/etc/bittorrent-distribution.yaml", help="YAML configuration file name")
    args = parser.parse_args()


    main(args)
