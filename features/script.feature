Feature: Run the experiment
    Scenario: Initialize
        When I successfully run `./script.py init`
        Then the output should contain exactly:
        """
        {"data": [], "host": [], "participant": {}}
        """

    Scenario: Join to empty experiment
        When I successfully run `./script.py join '{"host": [], "data": [], "participant": {}}' p1`
        Then the output should contain exactly:
        """
        {"data": ["p1"], "host": [], "participant": {"p1": []}}
        """

    Scenario: Join to not empty experiment
        When I successfully run `./script.py join '{"host": [1, 2, 3], "data": [4, 5], "participant": {"p2": [6, 7], "p3": [8]}}' p1`
        Then the output should contain exactly:
        """
        {"data": [4, 5, "p1"], "host": [1, 2, 3], "participant": {"p1": [], "p2": [6, 7], "p3": [8]}}
        """

    Scenario: Receive data from host
        When I successfully run `./script.py receive '{"host": [1, 2, 3], "data": [4, 5], "participant": {"p2": [6, 7], "p3": [8]}}' 9`
        Then the output should contain exactly:
        """
        {"data": [4, 5, 9], "host": [1, 2, 3, 9], "participant": {"p2": [6, 7], "p3": [8]}}
        """

    Scenario: Receive data from participant
        When I successfully run `./script.py receive '{"host": [1, 2, 3], "data": [4, 5], "participant": {"p2": [6, 7], "p3": [8]}}' 9 p3`
        Then the output should contain exactly:
        """
        {"data": [4, 5, 9], "host": [1, 2, 3], "participant": {"p2": [6, 7], "p3": [8, 9]}}
        """
