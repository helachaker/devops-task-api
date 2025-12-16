#!/bin/bash

# Quick Start Script for Task Manager API
# This script sets up and runs the project quickly

set -e  # Exit on error

echo "================================================"
echo "🚀 Task Manager API - Quick Start"
echo "================================================"
echo ""

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
echo "📋 Checking prerequisites..."
echo ""

if ! command_exists python3; then
    echo "❌ Python 3 is not installed. Please install Python 3.11+"
    exit 1
fi

if ! command_exists docker; then
    echo "❌ Docker is not installed. Please install Docker"
    exit 1
fi

if ! command_exists docker-compose; then
    echo "⚠️  docker-compose not found, trying docker compose..."
    if ! docker compose version >/dev/null 2>&1; then
        echo "❌ Docker Compose is not installed"
        exit 1
    fi
    COMPOSE_CMD="docker compose"
else
    COMPOSE_CMD="docker-compose"
fi

echo "✅ All prerequisites found!"
echo ""

# Ask user what they want to do
echo "What would you like to do?"
echo ""
echo "1) Run with Docker Compose (Recommended - includes Prometheus & Grafana)"
echo "2) Run locally with Python (Quick test)"
echo "3) Run tests only"
echo "4) Deploy to Kubernetes (minikube)"
echo "5) Setup project for development"
echo ""
read -p "Enter your choice (1-5): " choice
echo ""

case $choice in
    1)
        echo "🐳 Starting with Docker Compose..."
        echo ""
        
        # Build and start services
        $COMPOSE_CMD up -d --build
        
        echo ""
        echo "✅ Services started successfully!"
        echo ""
        echo "📍 Access Points:"
        echo "   • API:        http://localhost:5000"
        echo "   • Health:     http://localhost:5000/health"
        echo "   • Metrics:    http://localhost:5000/metrics"
        echo "   • Prometheus: http://localhost:9090"
        echo "   • Grafana:    http://localhost:3000 (admin/admin)"
        echo ""
        echo "📊 View logs: $COMPOSE_CMD logs -f app"
        echo "🛑 Stop: $COMPOSE_CMD down"
        echo ""
        
        # Wait for services to be ready
        echo "⏳ Waiting for services to be ready..."
        sleep 5
        
        # Test the API
        echo "🧪 Testing API..."
        if curl -sf http://localhost:5000/health > /dev/null; then
            echo "✅ API is healthy!"
            echo ""
            echo "🎉 Try creating a task:"
            echo "   curl -X POST http://localhost:5000/tasks \\"
            echo "     -H 'Content-Type: application/json' \\"
            echo "     -d '{\"title\":\"My First Task\",\"description\":\"Testing API\"}'"
        else
            echo "⚠️  API might still be starting up. Give it a few more seconds."
        fi
        ;;
        
    2)
        echo "🐍 Running locally with Python..."
        echo ""
        
        # Create virtual environment if it doesn't exist
        if [ ! -d "venv" ]; then
            echo "📦 Creating virtual environment..."
            python3 -m venv venv
        fi
        
        # Activate virtual environment
        echo "🔧 Activating virtual environment..."
        source venv/bin/activate
        
        # Install dependencies
        echo "📥 Installing dependencies..."
        pip install -q --upgrade pip
        pip install -q -r requirements.txt
        
        echo ""
        echo "✅ Setup complete!"
        echo ""
        echo "🚀 Starting application..."
        echo ""
        
        # Run the application
        python app.py
        ;;
        
    3)
        echo "🧪 Running tests..."
        echo ""
        
        # Create virtual environment if it doesn't exist
        if [ ! -d "venv" ]; then
            echo "📦 Creating virtual environment..."
            python3 -m venv venv
        fi
        
        # Activate virtual environment
        source venv/bin/activate
        
        # Install dependencies
        echo "📥 Installing dependencies..."
        pip install -q --upgrade pip
        pip install -q -r requirements.txt
        
        echo ""
        echo "🏃 Running pytest..."
        echo ""
        
        # Run tests
        pytest tests/ -v --cov=app --cov-report=term-missing
        
        echo ""
        echo "✅ Tests complete!"
        ;;
        
    4)
        echo "☸️  Deploying to Kubernetes..."
        echo ""
        
        # Check if minikube is installed
        if ! command_exists minikube; then
            echo "❌ minikube is not installed. Please install minikube first."
            exit 1
        fi
        
        # Check if minikube is running
        if ! minikube status | grep -q "Running"; then
            echo "🚀 Starting minikube..."
            minikube start --cpus=2 --memory=4096
        else
            echo "✅ minikube is already running"
        fi
        
        echo ""
        echo "🔨 Building Docker image..."
        eval $(minikube docker-env)
        docker build -t task-api:local .
        
        echo ""
        echo "📦 Applying Kubernetes manifests..."
        kubectl apply -f k8s/
        
        echo ""
        echo "⏳ Waiting for deployment to be ready..."
        kubectl wait --for=condition=available --timeout=120s deployment/task-api
        
        echo ""
        echo "✅ Deployment successful!"
        echo ""
        echo "📍 Access the API:"
        echo "   minikube service task-api-service --url"
        echo ""
        echo "📊 Check status:"
        echo "   kubectl get pods"
        echo "   kubectl get services"
        echo ""
        echo "📝 View logs:"
        echo "   kubectl logs -l app=task-api -f"
        ;;
        
    5)
        echo "🛠️  Setting up project for development..."
        echo ""
        
        # Create virtual environment
        if [ ! -d "venv" ]; then
            echo "📦 Creating virtual environment..."
            python3 -m venv venv
        fi
        
        # Activate virtual environment
        echo "🔧 Activating virtual environment..."
        source venv/bin/activate
        
        # Install dependencies
        echo "📥 Installing dependencies..."
        pip install --upgrade pip
        pip install -r requirements.txt
        pip install bandit safety  # Security tools
        
        echo ""
        echo "✅ Development environment ready!"
        echo ""
        echo "📝 Next steps:"
        echo "   1. Activate venv: source venv/bin/activate"
        echo "   2. Run app: python app.py"
        echo "   3. Run tests: pytest tests/"
        echo "   4. Run security scan: bandit -r ."
        echo ""
        echo "📚 See COMMANDS.sh for more commands"
        ;;
        
    *)
        echo "❌ Invalid choice. Please run the script again."
        exit 1
        ;;
esac

echo ""
echo "================================================"
echo "✨ Done! Happy coding!"
echo "================================================"
