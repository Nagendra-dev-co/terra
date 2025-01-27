import React, { useState } from 'react';
import { Building2, FileText, ChevronDown, Loader2, Upload, X, FileCheck } from 'lucide-react';

function App() {
  const [selectedCompany, setSelectedCompany] = useState('');
  const [selectedDocType, setSelectedDocType] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [file, setFile] = useState<File | null>(null);
  const [isDragging, setIsDragging] = useState(false);

  const companies = [
    'Apple Inc.',
    'Google',
    'Microsoft',
    'Amazon',
    'Meta',
    'Netflix',
    'Tesla',
    'IBM'
  ];

  const documentTypes = [
    'Job Description',
    'Resume'
  ];

  const handleSubmit = async () => {
    setIsSubmitting(true);
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 1500));
    setIsSubmitting(false);
    alert('Form submitted successfully!');
    setFile(null);
  };

  const handleDragOver = (e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(true);
  };

  const handleDragLeave = (e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(false);
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(false);
    
    const droppedFile = e.dataTransfer.files[0];
    if (droppedFile && droppedFile.type === 'application/pdf') {
      setFile(droppedFile);
    } else {
      alert('Please upload a PDF file');
    }
  };

  const handleFileInput = (e: React.ChangeEvent<HTMLInputElement>) => {
    const selectedFile = e.target.files?.[0];
    if (selectedFile && selectedFile.type === 'application/pdf') {
      setFile(selectedFile);
    } else {
      alert('Please upload a PDF file');
    }
  };

  const removeFile = () => {
    setFile(null);
  };

  const isFormValid = selectedCompany && selectedDocType && file;

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-50">
      <div className="container mx-auto px-4 py-16">
        <div className="max-w-3xl mx-auto">
          {/* Header */}
          <div className="text-center mb-12">
            <h1 className="text-4xl font-bold text-gray-900 mb-4">
              ATS Document Management
            </h1>
            <p className="text-lg text-gray-600">
              Select a company and document type to proceed
            </p>
          </div>

          {/* Dropdown Container */}
          <div className="bg-white rounded-xl shadow-lg p-8 space-y-6">
            {/* Company Dropdown */}
            <div className="space-y-2">
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Select Company
              </label>
              <div className="relative">
                <select
                  value={selectedCompany}
                  onChange={(e) => setSelectedCompany(e.target.value)}
                  className="block w-full pl-10 pr-4 py-3 text-base border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 appearance-none bg-white"
                >
                  <option value="">Choose a company</option>
                  {companies.map((company) => (
                    <option key={company} value={company}>
                      {company}
                    </option>
                  ))}
                </select>
                <Building2 className="absolute left-3 top-3.5 h-5 w-5 text-gray-400" />
                <ChevronDown className="absolute right-3 top-3.5 h-5 w-5 text-gray-400" />
              </div>
            </div>

            {/* Document Type Dropdown */}
            <div className="space-y-2">
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Select Document Type
              </label>
              <div className="relative">
                <select
                  value={selectedDocType}
                  onChange={(e) => {
                    setSelectedDocType(e.target.value);
                    setFile(null); // Clear file when changing document type
                  }}
                  className="block w-full pl-10 pr-4 py-3 text-base border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 appearance-none bg-white"
                >
                  <option value="">Choose document type</option>
                  {documentTypes.map((type) => (
                    <option key={type} value={type}>
                      {type}
                    </option>
                  ))}
                </select>
                <FileText className="absolute left-3 top-3.5 h-5 w-5 text-gray-400" />
                <ChevronDown className="absolute right-3 top-3.5 h-5 w-5 text-gray-400" />
              </div>
            </div>

            {/* File Upload Section */}
            {selectedDocType && (
              <div className="mt-6">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Upload {selectedDocType} (PDF)
                </label>
                
                {!file ? (
                  <div
                    onDragOver={handleDragOver}
                    onDragLeave={handleDragLeave}
                    onDrop={handleDrop}
                    className={`border-2 border-dashed rounded-lg p-8 text-center transition-colors ${
                      isDragging
                        ? 'border-blue-500 bg-blue-50'
                        : 'border-gray-300 hover:border-blue-400'
                    }`}
                  >
                    <input
                      type="file"
                      accept=".pdf"
                      onChange={handleFileInput}
                      className="hidden"
                      id="file-upload"
                    />
                    <div className="flex flex-col items-center">
                      <Upload className="h-12 w-12 text-gray-400 mb-4" />
                      <p className="text-gray-600 mb-2">
                        Drag and drop your {selectedDocType.toLowerCase()} PDF file here, or
                      </p>
                      <label
                        htmlFor="file-upload"
                        className="cursor-pointer text-blue-600 hover:text-blue-700 font-medium"
                      >
                        browse to upload
                      </label>
                      <p className="text-sm text-gray-500 mt-2">
                        {selectedDocType === 'Resume' 
                          ? 'Upload your resume in PDF format'
                          : 'Upload the job description document in PDF format'}
                      </p>
                    </div>
                  </div>
                ) : (
                  <div className="bg-blue-50 rounded-lg p-4 flex items-center justify-between">
                    <div className="flex items-center">
                      <FileCheck className="h-6 w-6 text-blue-600 mr-3" />
                      <div>
                        <p className="text-sm font-medium text-gray-900">{file.name}</p>
                        <p className="text-sm text-gray-500">
                          {(file.size / 1024 / 1024).toFixed(2)} MB
                        </p>
                      </div>
                    </div>
                    <button
                      onClick={removeFile}
                      className="text-gray-400 hover:text-gray-500"
                    >
                      <X className="h-5 w-5" />
                    </button>
                  </div>
                )}
              </div>
            )}

            {/* Selection Display */}
            {(selectedCompany || selectedDocType || file) && (
              <div className="mt-8 p-4 bg-blue-50 rounded-lg">
                <h3 className="text-lg font-medium text-blue-900 mb-2">Your Selection:</h3>
                <ul className="space-y-2 text-blue-800">
                  {selectedCompany && (
                    <li className="flex items-center">
                      <Building2 className="h-5 w-5 mr-2" />
                      Company: {selectedCompany}
                    </li>
                  )}
                  {selectedDocType && (
                    <li className="flex items-center">
                      <FileText className="h-5 w-5 mr-2" />
                      Document Type: {selectedDocType}
                    </li>
                  )}
                  {file && (
                    <li className="flex items-center">
                      <FileCheck className="h-5 w-5 mr-2" />
                      File: {file.name}
                    </li>
                  )}
                </ul>
              </div>
            )}

            {/* Submit Button */}
            <button
              onClick={handleSubmit}
              disabled={!isFormValid || isSubmitting}
              className={`w-full py-3 px-4 rounded-lg flex items-center justify-center text-white font-medium transition-all duration-200 ${
                isFormValid && !isSubmitting
                  ? 'bg-blue-600 hover:bg-blue-700 active:bg-blue-800'
                  : 'bg-gray-400 cursor-not-allowed'
              }`}
            >
              {isSubmitting ? (
                <>
                  <Loader2 className="animate-spin h-5 w-5 mr-2" />
                  Submitting...
                </>
              ) : (
                'Submit'
              )}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;