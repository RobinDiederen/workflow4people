/*

 * Workflow4people
 * Copyright 2009-2010, Open-T B.V., and individual contributors as indicated
 * by the @author tag. See the copyright.txt in the distribution for a
 * full listing of individual contributors.
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License
 * version 3 published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.

 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see http://www.gnu.org/licenses
 */
package org.workflow4people.services;
import org.workflow4people.*;
import org.jbpm.pvm.internal.identity.spi.*
import java.util.List;

import org.jbpm.api.identity.Group;
import org.jbpm.api.identity.User;

/**
 * jBPM identity interface to the acegi/spring security security module
 * Users and groups are maintained in acegi/spring security so all functions related to maintenance are unsupported
 *
 * @author Joost Horward
 */
public class IdentitySession implements org.jbpm.pvm.internal.identity.spi.IdentitySession {
	
	boolean transactional=true

	@Override
	public String createGroup(String arg0) {
		// Unsupported action
		return null;
	}

	@Override
	public String createGroup(String arg0, String arg1) {
		// Unsupported action
		return null;
	}

	@Override
	public String createGroup(String arg0, String arg1, String arg2) {
		// Unsupported action
		return null;
	}

	@Override
	public void createMembership(String arg0, String arg1) {
		// Unsupported action

	}

	@Override
	public void createMembership(String arg0, String arg1, String arg2) {
		// Unsupported action

	}

	@Override
	public void createUser(String arg0, String arg1, String arg2) {
		// Unsupported action

	}
/*
	@Override
	public void createUser(String arg0, String arg1, String arg2, String arg3) {
		// TUnsupported action

	}
	*/
	
	@Override
	public String createUser(String arg0, String arg1, String arg2, String arg3) {
		// Unsupported action

	}

	@Override
	public void deleteGroup(String arg0) {
		// Unsupported action

	}

	@Override
	public void deleteMembership(String arg0, String arg1, String arg2) {
		// Unsupported action

	}

	@Override
	public void deleteUser(String arg0) {
		// Unsupported action

	}

	@Override
	public Group findGroupById(String groupId) {
		def authority=Authority.findByAuthority(groupId)
		if (authority) {
			return new JbpmGroup(authority.authority,authority.authority,authority.authorityType)
		} else {
			return null
		}
	}

	@Override
	public List<String> findGroupIdsByUser(String username) {
		def person=Person.findByUsername(username)
		log.debug "Find Groups Ids"
		def res = person?.authorities?.collect { authority -> return authority.authority }
		return res?res:[]
	}

	@Override
	public List<Group> findGroupsByUser(String username) {
		Person person=Person.findByUsername(username)
		def res = person?.authorities?.collect { authority -> return new JbpmGroup(authority.authority,authority.authority,authority.authorityType)}
		return res?res:[]
		
	}

	@Override
	public List<Group> findGroupsByUserAndGroupType(String username, String groupType) {
		def person=Person.findByUsername(username)
		def groups=[]
		person.authorities.each { authority -> 
		if(authority.authorityType==groupType)
			groups+=new JbpmGroup(authority.authority,authority.authority,authority.authorityType)
		}
		return groups
	}

	@Override
	public User findUserById(String username) {
		def person = Person.findByUsername(username)
		if(person) {
			return new JbpmUser(person.username,person.familyName,person.givenName,person.email)
		} else {
			return null 
		}
	}

	@Override
	public List<User> findUsers() {		
		return Person.findAll().collect { person -> new JbpmUser(person.username,person.familyName,person.givenName,person.email) };
	}
	
	@Override
	public List<User> findUsersByGroup(String groupId) {
		def authority=Authority.findByAuthority(groupId)		
		def res = authority?.people?.collect { person -> new JbpmUser(person.username,person.familyName,person.givenName,person.email) };
		return res?res:[]
	}
	
	@Override
	public List<User> findUsersById(String... userIds) {
		def c=Person.createCriteria()
		def results=c.list {
			'in'("username",userIds)
		}
		def res= results.collect { person -> new JbpmUser(person.username,person.familyName,person.givenName,person.email) };
		return res?res:[]
	}
	
	

}
