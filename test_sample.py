from CommitExample import *
import pytest

def test_correct():
    assert testCommit(2, 3) == 6

def test_wrong():
    assert testCommit(2, 3) == 6
