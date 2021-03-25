FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
ENV HELM_VERSION=v3.5.3
ENV TF_DOCS_VERSION=v0.12.0
ENV TF_LINT_VERSION=v0.25.0
ENV TF_SEC_VERSION=v0.39.11
ENV PRE_COMMIT_HOME=/tmp/pre-commit
RUN apt update \
    && apt install -yf \
    curl \
    git \
    gawk \
    unzip \
    software-properties-common \
    python3-pip \
    && pip3 install -U pre-commit checkov \
    && rm -rf /var/lib/apt/lists/*
RUN curl -Lo helm.tar.gz https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz \
    && tar -zxvf helm.tar.gz \
    && chmod +x linux-amd64/helm \
    && mv linux-amd64/helm /bin/ \
    && rm -rf linux-amd64 helm.tar.gz
RUN curl -Lo terraform-docs https://github.com/terraform-docs/terraform-docs/releases/download/$TF_DOCS_VERSION/terraform-docs-$TF_DOCS_VERSION-linux-amd64 \
    && chmod +x terraform-docs \
    && mv terraform-docs /bin/
RUN curl -Lo tf-lint.zip https://github.com/terraform-linters/tflint/releases/download/$TF_LINT_VERSION/tflint_linux_amd64.zip \
    && unzip tf-lint.zip \
    && mv tflint /bin/ \
    && rm -f tf-lint.zip
RUN curl -Lo tfsec https://github.com/tfsec/tfsec/releases/download/$TF_SEC_VERSION/tfsec-linux-amd64 \
    && chmod +x tfsec \
    && mv tfsec /bin/
