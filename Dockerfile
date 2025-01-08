# Use an official Python base image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install necessary dependencies including git-lfs
RUN apt-get update && apt-get install -y \
    git \
    git-lfs \
    && git lfs install \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy project files into the container
COPY . /app

# Pull LFS-tracked files
RUN git lfs pull

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Make the setup.sh file executable (if used)
RUN chmod +x setup.sh

# Expose the port that Streamlit will run on
EXPOSE 8501

# Run the Streamlit app
CMD ["streamlit", "run", "app.py", "--server.port", "$PORT", "--server.headless", "true"]
