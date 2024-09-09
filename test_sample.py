from function_example import *
import pytest

def test_correct():
    assert function_one(2, 3) == 6

def test_wrong():
    assert function_one(2, 3) == 6
