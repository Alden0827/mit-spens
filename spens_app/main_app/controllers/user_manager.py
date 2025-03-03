from django.contrib.auth.models import User, Group
from django.core.exceptions import ObjectDoesNotExist

def create_user(username, email, password, first_name='', last_name=''):
    """
    Creates a new user.
    
    Usage:
        create_user('john_doe', 'john@example.com', 'password123', 'John', 'Doe')
    """
    if User.objects.filter(username=username).exists():
        return f"User {username} already exists."
    
    user = User.objects.create_user(
        username=username,
        email=email,
        password=password,
        first_name=first_name,
        last_name=last_name
    )
    return user

def update_user(user_id, **kwargs):
    """
    Updates user details.
    
    Usage:
        update_user(1, first_name='John', last_name='Doe')
    """
    try:
        user = User.objects.get(id=user_id)
        for key, value in kwargs.items():
            setattr(user, key, value)
        user.save()
        return user
    except ObjectDoesNotExist:
        return "User not found."

def delete_user(user_id):
    """
    Deletes a user.
    
    Usage:
        delete_user(1)
    """
    try:
        user = User.objects.get(id=user_id)
        user.delete()
        return "User deleted successfully."
    except ObjectDoesNotExist:
        return "User not found."

def get_user_groups(user_id):
    """
    Retrieves all groups of a user.
    
    Usage:
        get_user_groups(1)
    """
    try:
        user = User.objects.get(id=user_id)
        return list(user.groups.values("id", "name"))
    except ObjectDoesNotExist:
        return "User not found."

def add_user_to_group(user_id, group_name):
    """
    Adds a user to a group.
    
    Usage:
        add_user_to_group(1, 'Admin')
    """
    try:
        user = User.objects.get(id=user_id)
        group, created = Group.objects.get_or_create(name=group_name)
        user.groups.add(group)
        return f"User added to group {group_name}."
    except ObjectDoesNotExist:
        return "User not found."

def remove_user_from_group(user_id, group_name):
    """
    Removes a user from a group.
    
    Usage:
        remove_user_from_group(1, 'Admin')
    """
    try:
        user = User.objects.get(id=user_id)
        group = Group.objects.get(name=group_name)
        user.groups.remove(group)
        return f"User removed from group {group_name}."
    except ObjectDoesNotExist:
        return "User or group not found."

def get_users_in_group(group_name):
    """
    Retrieves all users in a group.
    
    Usage:
        get_users_in_group('Admin')
    """
    try:
        group = Group.objects.get(name=group_name)
        return list(group.user_set.values("id", "username"))
    except ObjectDoesNotExist:
        return "Group not found."

def check_user_in_group(user_id, group_name):
    """
    Checks if a user is in a specific group.
    
    Usage:
        check_user_in_group(1, 'Admin')
    """
    try:
        user = User.objects.get(id=user_id)
        return user.groups.filter(name=group_name).exists()
    except ObjectDoesNotExist:
        return "User not found."

def list_all_groups():
    """
    Returns a list of all available groups.
    
    Usage:
        list_all_groups()
    """
    return list(Group.objects.values("id", "name"))
