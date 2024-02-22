const fs = require('fs');

// Function to clean and arrange data from CSV file
function cleanAndArrangeCSV(inputFilename, outputFilename) {
  const outputData = [];

  // Read the CSV file
  const csvData = fs.readFileSync(inputFilename, 'utf-8');

  // Split the CSV data into individual rows based on newline characters
  const rows = csvData.trim().split('\n');

  // Process each row
  rows.forEach((row) => {
    // Split the row into individual values based on commas
    const values = row.split(',');

    // Trim whitespace from each value
    const cleanedValues = values.map((value) => value.trim());

    // Arrange the values into respective columns
    const cleanedRow = {
      name: cleanedValues[0],
      price: parseFloat(cleanedValues[1].replace('US$', '').replace(',', '')), // Remove currency symbol and commas
      imgurl: cleanedValues[2],
      description: cleanedValues.slice(3, cleanedValues.length - 1).join(', '),
     quantity: cleanedValues[cleanedValues.length - 1]  // Extract quantity range and parse as integer
    };

    outputData.push(cleanedRow);
  });

  // Write cleaned and arranged data to a new CSV file
  const csvOutputData = outputData.map(row => `${row.name},${row.price},${row.imgurl},${row.description},${row.quantity}`).join('\n');
  fs.writeFileSync(outputFilename, `name,price,imgurl,description,quantity\n${csvOutputData}`);

  console.log(`Cleaned data written to ${outputFilename}`);
}


// Example usage:
cleanAndArrangeCSV('phones.csv', 'phone.csv');
