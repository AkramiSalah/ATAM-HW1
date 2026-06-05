#!/bin/bash

echo "Starting massive test run..."
echo "----------------------------"

for test_file in example_tests/whatsapp_tests/*.asm; do
    # Extract just the filename without the path
    filename=$(basename -- "$test_file")
    
    # Match the prefix to the correct student assignment
    if [[ $filename == q1_* ]]; then
        ./run_test.sh student_files/ex1.asm "$test_file"
        
    elif [[ $filename == q2_* ]]; then
        ./run_test.sh student_files/ex2.asm "$test_file"
        
    # Make sure to check q3_bonus BEFORE q3 so they don't get mixed up
    elif [[ $filename == q3_bonus_* ]]; then
        ./run_test.sh student_files/ex3_bonus_decoder.asm "$test_file"
        
    elif [[ $filename == q3_* ]]; then
        ./run_test.sh student_files/ex3.asm "$test_file"
        
    elif [[ $filename == q4_* ]]; then
        ./run_test.sh student_files/ex4.asm "$test_file"
    fi
done

echo "----------------------------"
echo "All tests completed!"
