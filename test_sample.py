from CommitExample import *
import pytest

def test_correct():
    assert CommitExample(2, 3) == 6

def test_wrong():
    assert CommitExample(2, 3) == 6