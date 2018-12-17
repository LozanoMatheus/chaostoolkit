# Chaos Toolkit

This project was created to test, create some demos and try to help [Chaostoolkit community](https://github.com/chaostoolkit/chaostoolkit).

_Note: The Docker images will automatically builded using auto build/webhook._

---

## Index

* [Dependencies](https://github.com/LozanoMatheus/chaostoolkit#dependencies)
* [Demo image](https://github.com/LozanoMatheus/chaostoolkit#demo-image)
* [Environment variables](https://github.com/LozanoMatheus/chaostoolkit#environment-variables)
  * [Journal file](https://github.com/LozanoMatheus/chaostoolkit#journal-file)
  * [Enable Reports](https://github.com/LozanoMatheus/chaostoolkit#enable-reports)
  * [Reports path](https://github.com/LozanoMatheus/chaostoolkit#reports-path)
  * [Report output format](https://github.com/LozanoMatheus/chaostoolkit#report-output-format)

---

## Dependencies

* __[Docker](https://docs.docker.com/install/)__ - Using 17.02 or above

## Demo image

I create an image with everything we need to test this tool. So, this is a ~~non-production~~ big image.

## Environment variables

### Journal file

The journal file contains the result of the tests and we'll use it to generate our reports.

* If you want to change the journal file name, you can do it.

```bash
docker run --rm -e "JOURNAL_FILE=my_journal.json" lozanomatheus/chaostoolkit:demo
```

_Note: The default value for `JOURNAL_FILE` is `journal.json`_

### Enable Reports

This option is to enable or disable the reports output. If you set anything different from `ENABLED`, the report generation will be ignored.

* To disable reports, we can do it:

```bash
docker run --rm -e "REPORT=''" lozanomatheus/chaostoolkit:demo
```

or

```bash
docker run --rm -e "REPORT=" lozanomatheus/chaostoolkit:demo
```

or

```bash
docker run --rm -e "REPORT=DISABLED" lozanomatheus/chaostoolkit:demo
```

_Note: The default value for `REPORT` is `ENABLED`_

### Reports path

The environment variable `REPORTS_PATH` is the path with all reports.

* If you want to export it to a local path, you can follow the example below.

```bash
docker run --rm -v ${PWD}:/opt/reports lozanomatheus/chaostoolkit:demo
```

* If you want to change the path inside the container and export to a local path, you can use this example.

```bash
docker run --rm -e "REPORTS_PATH=/tmp/reports" -v ${PWD}:/tmp/reports lozanomatheus/chaostoolkit:demo
```

_Note: The default value for `REPORTS_PATH` is `/opt/reports`_

### Report output format

Has two ways to generate the reports. The first one is passing two options, like `html5 pdf` and the second one is just one option, like `html5` or `pdf`.

* To choose the option, we need to set `REPORT_FORMAT` variable. To do it, you can do this way:

```bash
docker run --rm -e "REPORT_FORMAT=html5 pdf" lozanomatheus/chaostoolkit:demo
```

_Note1: The default value for `REPORT_FORMAT` is `html5 pdf`_

_Note2: The Chaos Toolkit just accept PDF or HTML5 as output format._
