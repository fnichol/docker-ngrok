# docker-ngrok

A [Docker][docker] image for [ngrok][ngrok], introspected tunnels to localhost. The image is built using [Alpine Linux][alpine] to keep the footprint as small as possible.

The container will tunnel either HTTP or HTTPS traffic by using the `HTTPS_PORT` or `HTTP_PORT` environment variables. Either environment variable can be set using the `-e` flag when running an ngrok container or by using [linked containers](https://docs.docker.com/userguide/dockerlinks/#container-linking), which is shown below.

## Getting the Image

This image is hosted on the Docker index as a trusted build and can be pulled down with:

    docker pull fnichol/ngrok

## Usage

We'll set up a simple HTTP server in a docker container called `www`:

    docker run -v /www --name www_data busybox true
    docker run --rm --volumes-from www_data busybox \
      /bin/sh -c 'echo "<h1>Yo</h1>" > /www/index.html'
    docker run -d -p 80 --volumes-from www_data --name www fnichol/uhttpd

Now we'll link the HTTP server container into an ngrok container to expose the server on the internet:

    docker run -d -p 4040 --link www:http --name www_ngrok fnichol/ngrok

To get the `*.ngrok.com` address, check the container's logs:

    docker logs www_ngrok

The ngrok web inspection interface is running on port 4040. To get the exposed port:

    docker port www_ngrok 4040

## Development

* Source host at [GitHub][repo]
* Report issues/questions/feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested. Ideally create a topic branch for every separate change you make. For example:

1. Fork the repo
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add support for feature'`)
4. Push to the branch (`git push origin my-new-feature`)

## Authors

Created and maintained by [Fletcher Nichol][fnichol] (<fnichol@nichol.ca>).

## License

MIT (see [License.txt][license])

[fnichol]:  https://github.com/fnichol
[repo]:     https://github.com/fnichol/docker-ngrok
[issues]:   https://github.com/fnichol/docker-ngrok/issues
[license]:  https://github.com/fnichol/docker-ngrok/blob/master/License.txt

[docker]:           https://www.docker.io/
[alpine]:           https://hub.docker.com/_/alpine/
[ngrok]:            https://ngrok.com/
